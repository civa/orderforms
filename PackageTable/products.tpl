<link rel="stylesheet" id="slider-4-css" type="text/css" href="{$WEB_ROOT}/templates/orderforms/{$carttpl}/css/tableStyle.css" media="all" />
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

        <div id="mySidebar" class="col-md-3 pull-md-right custom-sidebar sidebar hidden-xs hidden-sm">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div>
        <div class="table-cnt-box" id="comparison_table">
            <button class="openbtn hidden-xs hidden-sm" onclick="openNav()"><span></span></button>
            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}
            {foreach $hookAboveProductsOutput as $output}
                <div>
                    {$output}
                </div>
            {/foreach}

            <ul>
                {assign var=flag value="0"}
                {foreach $products as $key => $p}
                    <li class="{if $p.isFeatured and flag eq 0}active{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}active{assign var=flag value="1"}{/if}">
                        <button>{$p.name}</button>
                    </li>
                    {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                {/foreach}
            </ul>


           <table>
               <thead>
               <tr>
                   <th class="hide1"></th>
                   {foreach $products as $key => $p}
                       <th class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">{$p.name}</th>
                       {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                   {/foreach}
               </tr>
               </thead>
               <tbody>
               <tr>
                   <td>Price</td>
                   {foreach $products as $key => $p}
                       <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
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
                       {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                   {/foreach}

               </tr>
               {if $isAnyPackHaveSetupFee>0}
               <tr>
                   <td>{$LANG.ordersetupfee}</td>
                   {foreach $products as $key => $p}
                       <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                           <span class="txt-l">
                               {if $p.pricing.minprice.setupFee}
                                   {$p.pricing.minprice.setupFee->toPrefixed()}
                               {else}
                                   -
                               {/if}
                           </span>
                       </td>
                       {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                   {/foreach}
               </tr>
               {/if}
               <tr>
                   <td colspan="{$totalPackages+1}" class="sep">
                       {if $productGroup.headline}
                           {$productGroup.headline}
                       {else}
                           {$productGroup.name}
                       {/if}
                   </td>
               </tr>

               {foreach $featuresIndexes as $key => $Index}
                   <tr>
                       <td>{$Index}</td>
                       {foreach $products as $key => $p}
                           <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                               {if isset($p.features.{$Index}) and !empty($p.features.{$Index})}
                                   {$p.features.{$Index}}
                               {else}
                                   -
                               {/if}
                           </td>
                           {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                       {/foreach}
                   </tr>
               {/foreach}
               {if $isAnyPackHaveFeatureDescription>0}
                   <tr>
                       <td>{$LANG.orderdesc}</td>
                       {foreach $products as $key => $p}
                           <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">

                               {if !empty($p.featuresdesc)}
                                   {$p.featuresdesc}
                               {else}
                                   -
                               {/if}

                           </td>
                           {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                       {/foreach}
                   </tr>
               {/if}

               <tr>
                   <td class="hide1"></td>
                   {foreach $products as $key => $p}
                       <td class="{if $p.isFeatured and flag eq 0}default{assign var=flag value="1"}{elseif $p@iteration eq 1 and flag eq 0 and $isAnyFeaturedPackage eq 0}default{assign var=flag value="1"}{/if}">
                           {if $p.qty eq "0"}
                              {$LANG.outofstock}
                           {else}
{*                               <a href="{$smarty.server.PHP_SELF}?a=add&amp;{if $p.bid}bid={$p.bid}{else}pid={$p.pid}{/if}" class="btn btn-default btn-lg btn-3d">*}
{*                                   {$LANG.ordernowbutton}*}
{*                               </a>*}

                               <a href="{$WEB_ROOT}/cart.php?a=add&{if $p.bid}bid={$p.bid}{else}pid={$p.pid}{/if}" class="btn btn-default btn-lg btn-3d" id="product{$p@iteration}-order-button">
                                   <i class="fas fa-shopping-cart"></i>
                                   {$LANG.ordernowbutton}
                               </a>
                           {/if}
                       </td>
                       {if $p@iteration == $TotalPackagetoShow}{break}{/if}
                   {/foreach}
               </tr>

               </tbody>
           </table>


            {foreach $hookBelowProductsOutput as $output}
                <div>
                    {$output}
                </div>
            {/foreach}


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
            document.getElementById("comparison_table").style.marginRight="300px";
            toggle = true;
        }
        else
        {
            document.getElementById("mySidebar").style.width = "0";
            document.getElementById("comparison_table").style.marginRight = "0";
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