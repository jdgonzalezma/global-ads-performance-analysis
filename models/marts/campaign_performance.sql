with staging as (

    select * from {{ ref('stg_ads_performance') }}

),

aggregated as (

    select
        date_trunc('month', campaign_date) as month,
        platform,
        campaign_type,

        sum(impressions)   as total_impressions,
        sum(clicks)         as total_clicks,
        sum(conversions)    as total_conversions,
        sum(ad_spend)       as total_spend,
        sum(revenue)        as total_revenue,

        -- métricas recalculadas a nivel agregado
        round(sum(clicks)::double / sum(impressions), 4)        as ctr,
        round(sum(ad_spend)::double / sum(clicks), 2)           as cpc,
        round(sum(ad_spend)::double / sum(conversions), 2)      as cpa,
        round(sum(revenue)::double / sum(ad_spend), 2)          as roas

    from staging

    group by 1, 2, 3

)

select * from aggregated
order by month, platform, campaign_type
