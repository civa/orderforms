<link rel="stylesheet" id="slider-4-css" type="text/css" href="{$WEB_ROOT}/templates/orderforms/{$carttpl}/css/tableStyle.css" media="all" />
<script  id="slider-4-js" type="text/javascript" src="{$WEB_ROOT}/templates/orderforms/{$carttpl}/js/table.js" media="all"></script>
{include file="orderforms/$carttpl/common.tpl"}

<div id="order-standard_cart">
    <div class="row">
        <div class="pull-md-right col-md-12">
            <div class="header-lined">
                <h1>
                    {if $productGroup.headline}
                        {$productGroup.headline}
                    {else}
                        {$productGroup.name}
                    {/if}
                </h1>
                {if $productGroup.tagline}
                    <p>{$productGroup.tagline}</p>
                {/if}
            </div>
            {if $errormessage}
                <div class="alert alert-danger">
                    {$errormessage}
                </div>
            {/if}
        </div>

        <div class="pull-left slider-content-outerbox">

        <div id="mySidebar" class="col-md-3 pull-md-right sidebar custom-sidebar hidden-xs hidden-sm">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div>
        <div class="table-cnt-box" id="pricing_plan">
            <button class="openbtn hidden-xs hidden-sm" onclick="openNav()"><span></span></button>
            <table class="dedicated_table">
                <thead>
                <tr>
                    {foreach $featuresIndexes as $key => $Index}
                            <th>{$Index}</th>
                    {/foreach}
                    <th>Price</th>
                     {if $isAnyPackHaveSetupFee>0}
                        <th>{$LANG.ordersetupfee}</th>
                     {/if}
                    {*{if $isAnyPackHaveFeatureDescription>0}
                        <th>{$LANG.orderdesc}</th>
                    {/if}*}
                    <th></th>
                </tr>
                </thead>
                <tbody>
                {foreach $products as $key => $p}
                <tr class="{if $p.isFeatured and flag eq 0}featuerPackage{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}featuerPackage{assign var=flag value="1"}{/if}">
                    {foreach $featuresIndexes as $key => $Index}
                        <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                            {if isset($p.features.{$Index}) and !empty($p.features.{$Index})}
                                {$p.features.{$Index}}
                            {else}
                                -
                            {/if}
                        </td>
                    {/foreach}

                    <td class="price_row {if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                        {if $p.bid}
                            {if $p.displayprice}
                                <span class="txt-l">{$p.displayprice}</span>
                                {$LANG.bundledeal}
                            {/if}
                        {else}
                            <span class="txt-l">{$p.pricing.minprice.price}</span>
                            {if $p.pricing.minprice.cycle eq "monthly"}
                                {$LANG.orderpaymenttermmonthly}
                            {elseif $p.pricing.minprice.cycle eq "quarterly"}
                                {$LANG.orderpaymenttermquarterly}
                            {elseif $p.pricing.minprice.cycle eq "semiannually"}
                                {$LANG.orderpaymenttermsemiannually}
                            {elseif $p.pricing.minprice.cycle eq "annually"}
                                {$LANG.orderpaymenttermannually}
                            {elseif $p.pricing.minprice.cycle eq "biennially"}
                                {$LANG.orderpaymenttermbiennially}
                            {elseif $p.pricing.minprice.cycle eq "triennially"}
                                {$LANG.orderpaymenttermtriennially}
                            {/if}
                        {/if}
                    </td>
                    {if $isAnyPackHaveSetupFee>0}
                        <td class="price_row {if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                            {if $p.pricing.minprice.setupFee}
                                {$p.pricing.minprice.setupFee->toPrefixed()}
                            {else}
                                -
                            {/if}
                        </td>
                    {/if}
                    {*{if $isAnyPackHaveFeatureDescription>0}
                        <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                                    {if !empty($p.featuresdesc)}
                                        {$p.featuresdesc}
                                    {else}
                                        -
                                    {/if}
                        </td>
                    {/if}*}
                    <td class="table_btn {if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                        {if $p.qty eq "0"}
                            {$LANG.outofstock}
                        {else}
{*                            <a href="{$smarty.server.PHP_SELF}?a=add&amp;{if $p.bid}bid={$p.bid}{else}pid={$p.pid}{/if}" class="">*}
{*                                {$LANG.ordernowbutton}*}
{*                            </a>*}

                            <a href="{$WEB_ROOT}/cart.php?a=add&{if $p.bid}bid={$p.bid}{else}pid={$p.pid}{/if}" class="btn btn-default btn-lg btn-3d" id="product{$p@iteration}-order-button">
                                <i class="fas fa-shopping-cart"></i>
                                {$LANG.ordernowbutton}
                            </a>
                        {/if}
                    </td>
                </tr>
                    {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                {/foreach}
                
                </tbody>
            </table>
        </div>

        </div>
</div>

<script>
    jQuery('.dedicated_table').stacktable();

    var toggle = false;
    function openNav() {
        if (toggle == false)
        {
            document.getElementById("mySidebar").style.width="300px";
            document.getElementById("pricing_plan").style.marginRight="300px";
            toggle = true;
        }
        else
        {
            document.getElementById("mySidebar").style.width = "0";
            document.getElementById("pricing_plan").style.marginRight ="0";
            toggle = false;
        }
    }

    var el = document.getElementsByClassName('openbtn');
    var el_len = el.length;

    for(i = 0; i < el_len; i++) {
        el[i].addEventListener('click', function() {
            this.classList.toggle('active');
        })

    }

</script>
