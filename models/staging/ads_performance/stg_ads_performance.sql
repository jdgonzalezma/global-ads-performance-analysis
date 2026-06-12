with source as (

    select * from read_csv_auto('data/raw/global_ads_performance_dataset.csv')

),

renamed as (

    select
        date::date           as campaign_date,
        platform,
        campaign_type,
        industry,
        country,
        impressions::bigint   as impressions,
        clicks::bigint        as clicks,
        ctr::double           as ctr,
        cpc::double           as cpc,
        ad_spend::double      as ad_spend,
        conversions::bigint   as conversions,
        cpa::double           as cpa,
        revenue::double       as revenue,
        roas::double          as roas

    from source

)

select * from renamed
