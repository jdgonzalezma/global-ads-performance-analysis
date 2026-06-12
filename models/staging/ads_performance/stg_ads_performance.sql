with source as (

    select 
        *,
        row_number() over () as row_num
    from read_csv_auto('data/raw/global_ads_performance_dataset.csv')

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['date', 'platform', 'campaign_type', 'industry', 'country', 'row_num']) }} as campaign_record_id,

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
