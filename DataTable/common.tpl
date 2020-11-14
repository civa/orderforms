{*Restrict number of packages to be shown on front end*}
{assign var=TotalPackagetoShow value="20" scope="global"}
{*Total number of package in selected group*}
{assign var=totalPackages value="{$products|@count}" scope="global"}
{*Initializing of variable which have later maximum number of total feature in any package*}
{assign var=totalfeaturesPerPackages value="0" scope="global"}
{*Check variable if any package have setup fee or not *}
{assign var=isAnyPackHaveSetupFee value="0" scope="global"}
{*Check variable if any package have feature description *}
{assign var=isAnyPackHaveFeatureDescription value="0" scope="global"}
{*Check variable if any feature package exist in group *}
{assign var=isAnyFeaturedPackage value="0" scope="global"}
{*Array of feature indexes *}
{assign var=featuresIndexOfMaxFeatureInPackages value=""}
{*Update variable with restricted number of shown package if below condition true *}
{if $totalPackages > $TotalPackagetoShow}
    {assign var=totalPackages value="{$TotalPackagetoShow}" scope="global"}
{/if}

{for $x=0 to $totalPackages-1}
    {if $totalfeaturesPerPackages < ($products.{$x}.features|@count)}
        {assign var=totalfeaturesPerPackages value="{$products.{$x}.features|@count}" scope="global"}
        {assign var=featuresIndexOfMaxFeatureInPackages value=""}
        {foreach $products.{$x}.features as $index => $value}
            {assign var=featuresIndexOfMaxFeatureInPackages value=$featuresIndexOfMaxFeatureInPackages|cat:{$index}|cat:','}
        {/foreach}
    {/if}


    {if $products.{$x}.pricing.minprice.setupFee > 0}
        {assign var=isAnyPackHaveSetupFee value="1" scope="global"}
    {/if}

    {if isset($products.{$x}.isFeatured) and $products.{$x}.isFeatured > 0}
        {assign var=isAnyFeaturedPackage value="1" scope="global"}
    {/if}

    {if isset($products.{$x}.featuresdesc) and !empty($products.{$x}.featuresdesc)}
        {assign var=isAnyPackHaveFeatureDescription value="1" scope="global"}
    {/if}
{/for}

{assign var=featuresIndexOfMaxFeatureInPackages value=$featuresIndexOfMaxFeatureInPackages|truncate:{$featuresIndexOfMaxFeatureInPackages|strlen -1}:"":TRUE}
{assign var=featuresIndexes value=","|explode:$featuresIndexOfMaxFeatureInPackages scope="global"}