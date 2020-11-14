<link rel="stylesheet" id="slider-4-css" type="text/css" href="{$WEB_ROOT}/templates/orderforms/{$carttpl}/css/planStyle.css" media="all" />
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

     <div class="pull-left pricing_plan_outerbox slider-content-outerbox">

        <div id="mySidebar" class="col-md-3 pull-md-right sidebar custom-sidebar hidden-xs hidden-sm">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div>

        <div class="slider-cnt-box" id="pricing_plan">
            <button class="openbtn hidden-xs hidden-sm" onclick="openNav()"><span></span></button>
            <div class="pricing_plan_outer">
                {foreach $products as $key => $p}
                    <div class="plan_box">
                    <div class="plan_box_cnt">
                    <h3 class="plan_heading">{$p.name}</h3>
                        {if $p.features|@count gt 0}
                        <ul id="plan_inner_ul">
                            {foreach $p.features as $featureName => $featureValue}
                                <li>{$featureName} <strong>{$featureValue}</strong></li>
                            {/foreach}
                        </ul>
                        {/if}
                        <div id="featured_description">
                        {if !empty($p.featuresdesc)}
                            {$p.featuresdesc}
                        {/if}
                        </div>
                        {if $p.pricing.minprice.setupFee}
                            <p class="plan_pricing"> <span class="plan_month_txt">{$LANG.ordersetupfee}</span>  <span class="dollar_price">{$p.pricing.minprice.setupFee->toPrefixed()}</span></p>
                        {/if}

                        <p class="plan_pricing">
                            {if $p.bid}
                                {if $p.displayprice}
                                    <span class="dollar_price">{$p.displayprice}</span>
                                    <span class="plan_month_txt">{$LANG.bundledeal}</span>
                                {/if}
                            {else}
                               <span class="dollar_price">{$p.pricing.minprice.price}</span>
                                {if $p.pricing.minprice.cycle eq "monthly"}
                                    <span class="plan_month_txt">{$LANG.orderpaymenttermmonthly}</span>
                                {elseif $p.pricing.minprice.cycle eq "quarterly"}
                                    <span class="plan_month_txt">{$LANG.orderpaymenttermquarterly}</span>
                                {elseif $p.pricing.minprice.cycle eq "semiannually"}
                                    <span class="plan_month_txt">{$LANG.orderpaymenttermsemiannually}</span>
                                {elseif $p.pricing.minprice.cycle eq "annually"}
                                    <span class="plan_month_txt">{$LANG.orderpaymenttermannually}</span>
                                {elseif $p.pricing.minprice.cycle eq "biennially"}
                                    <span class="plan_month_txt">{$LANG.orderpaymenttermbiennially}</span>
                                {elseif $p.pricing.minprice.cycle eq "triennially"}
                                    <span class="plan_month_txt">{$LANG.orderpaymenttermtriennially}</span>
                                {/if}
                            {/if}
                        </p>
                        {if $p.qty eq "0"}
                            {$LANG.outofstock}
                        {else}
                        <div class="plan_btn">
{*                            <a href="{$smarty.server.PHP_SELF}?a=add&amp;{if $p.bid}bid={$p.bid}{else}pid={$p.pid}{/if}" class="">*}
{*                                {$LANG.ordernowbutton}*}
{*                            </a>*}

                            <a href="{$WEB_ROOT}/cart.php?a=add&{if $p.bid}bid={$p.bid}{else}pid={$p.pid}{/if}" class="btn btn-default btn-lg btn-3d" id="product{$p@iteration}-order-button">
                                <i class="fas fa-shopping-cart"></i>
                                {$LANG.ordernowbutton}
                            </a>
                        </div>
                        {/if}
                    </div>
                </div>
                {/foreach}
            </div>

        </div>

    </div>


</div>

<script>// DIRTY Responsive pricing table JS

    $( "ul" ).on( "click", "li", function() {
        var pos = $(this).index()+2;
        $("tr").find('td:not(:eq(0))').hide();
        $('td:nth-child('+pos+')').css('display','table-cell');
        $("tr").find('th:not(:eq(0))').hide();
        $('li').removeClass('active');
        $(this).addClass('active');
    });

    // Initialize the media query
    var mediaQuery = window.matchMedia('(min-width: 640px)');

    // Add a listen event
    mediaQuery.addListener(doSomething);

    // Function to do something with the media query
    function doSomething(mediaQuery) {
        if (mediaQuery.matches) {
            $('.sep').attr('colspan',{$totalPackages+1});
        } else {
            $('.sep').attr('colspan',2);
        }
    }

    // On load
    doSomething(mediaQuery);

    var toggle = false;
    function openNav() {
        if (toggle == false)
        {
            document.getElementById("mySidebar").style.width = "300px";
            document.getElementById("pricing_plan").style.marginRight="300px";
            toggle = true;
        }
        else
        {
            document.getElementById("mySidebar").style.width = "0";
            document.getElementById("pricing_plan").style.marginRight = "0";
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