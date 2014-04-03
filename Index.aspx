<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Travel: Cheap Hotels, Air Tickets & Packages | Expedia.com.hk</title>
    <meta name="description" content="Expedia.com.hk: your one-stop online travel agent for the perfect holiday. Bringing you 1000s of cheap hotels, flights and holiday package deals.">
    <meta name="keywords" content="travel, travel agent, hotels, air tickets, flights, packages, Expedia.com.hk">

    <link href="style/new-header-min-2228788655.css" rel="stylesheet" />
    <link href="style/apac.homepage-min-3310516223.css" rel="stylesheet" />
    <link href="Style/hotelSearch.css-min-4025287383.css" rel="stylesheet" />
    <!-- 0 ms -->
    <!--[if IE 7]>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<![endif]-->
    <![if !(IE 7)]>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>

    <![endif]> 
    <link href="Style/jquery-ui-1.8.16/themes/base/jquery.ui.all.css" rel="stylesheet" />
    <link href="Style/jquery-easyui-1.3.4/themes/default/easyui.css" rel="stylesheet" />
      <%--  <script src="Style/jquery-easyui-1.3.4/jquery.min.js"></script> --%>
    <script src="Style/jquery-easyui-1.3.4/jquery.easyui.min.js"></script>
    <script src="Style/jquery-ui-1.8.16/ui/minified/jquery-ui.min.js"></script>
    <script src="Style/jquery-ui-1.8.16/ui/jquery.ui.core.js"></script>
    <link href="Style/fusion.v2.3.core-min-1276740553.css" rel="stylesheet" />
<%--    <link href="Style/core.css" rel="stylesheet" />--%>
    <!-- 0 ms -->
    <!--[if IE 6]><link href="Style/fusion.v2.3.coreIE6-min-3866661693.css" rel="stylesheet" />
 <!-- 0 ms -->
    <![endif]-->
    <style type="text/css">
        .xp-w-cell-dateField-large {
            width: 85px;
        }
    </style>
    <script src="hotels.js"></script>
    <script type="text/javascript">
        var jsonData = HotelJsondata;
        $(function () {
            $("#checkInDate").datepicker({
                numberOfMonths: 2,
                showButtonPanel: true
            });
            $("#checkOutDate").datepicker({
                numberOfMonths: 2,
                showButtonPanel: true
            });

        });
      
        var Citydata = new Array(jsonData.length);
        for (var i = 0; i < jsonData.length; i++) {
            Citydata[i] = jsonData[i]["userCity"];
        }
   
        $("#hot-hot-cityname").autocomplete({
            source: Citydata,
            minLength: 2
        });
        $('#searchdata').datagrid({
            data: jsonData,
            onLoadSuccess:function()
            {
                $('#searchdata').show();
               
                $('#datainfor').show();
            }
            
        });
        $('#datainfor').html("All matched hotels:");
        function SearchHotel() {
            
            var result=getSearchValue(); 
            $('#searchdata').datagrid('loadData', result);
           
            $('#datainfor').html("All matched hotels:" + result.length.toString());
            $('#datainfor').show();
        }

        function getSearchValue() {
            var search_query_data = []; 
            var checkInDate = $('#checkInDate').val() != "yyyy/mm/dd" && $('#checkInDate').val() != "" ? $('#checkInDate').val() : null;
            var checkOutDate = $('#checkInDate').val() != "yyyy/mm/dd" && $('#checkInDate').val() != "" ? $('#checkInDate').val() : null;
            var userCity = $("#hot-hot-cityname").val() != "" ? $("#hot-hot-cityname").val() : null;
            var province = $("#province").val() != "" ? $("#province").val() : null;
            
            var name = $("#hot-hot-name").val() != "" ? $("#hot-hot-name").val() : null;
            var streetAddress = $("#hot-hot-streetaddress").val() != "" ? $("#hot-hot-streetaddress").val() : null;
            var latitude = $("#hot-hot-latitude").val() != "" ? $("#hot-hot-latitude").val() : null;
            var longitude = $("#hot-hot-longtitude").val() != "" ? $("#hot-hot-longtitude").val() : null;
            var starRating = $("#hot-startrate").val() != "" ? $("#hot-startrate").val() : null;

            
            if (province != null) {
                for (var i = 0; i < jsonData.length; i++) {
                    if (("_"+jsonData[i]["province"]).indexOf(province)>0) {
                        search_query_data.push(jsonData[i]); 
                    }
                }
            }
            if (checkInDate != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) {

                        if (search_query_data[i]["checkInDate"] != checkInDate) {
                            search_query_data.splice(i,1);

                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {

                        if (jsonData[i]["checkInDate"] == checkInDate) {
                            search_query_data.push(jsonData[i]);

                        }
                    }

                }

            }
            if (checkOutDate != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) { 
                        if (search_query_data[i]["checkOutDate"] != checkOutDate) {
                            search_query_data.splice(i, 1); 
                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {
                        if (jsonData[i]["checkOutDate"] == checkOutDate) {
                            search_query_data.push(jsonData[i]);

                        }
                    }
                }
            }
            if (userCity != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) {
                        if (("_" + search_query_data[i]["userCity"]).indexOf(userCity) <= 0) {
                            search_query_data.splice(i, 1);
                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {
                        if (("_" + jsonData[i]["userCity"]).indexOf(userCity) > 0) {
                            search_query_data.push(jsonData[i]);

                        }
                    }
                }
            }
            if (name != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) {
                        if (("_" + search_query_data[i]["name"]).indexOf(name) <= 0) {
                            search_query_data.splice(i, 1);
                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {
                        if (("_" + jsonData[i]["name"]).indexOf(name) > 0) {
                            search_query_data.push(jsonData[i]);

                        }
                    }
                }
            }
            if (streetAddress != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) {
                        if (("_" + search_query_data[i]["streetAddress"]).indexOf(streetAddress) <= 0) {
                            search_query_data.splice(i, 1);
                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {
                        if (("_" + jsonData[i]["streetAddress"]).indexOf(streetAddress) > 0) {
                            search_query_data.push(jsonData[i]);

                        }
                    }
                }
            }
            if (latitude != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) {
                        if (("_" + search_query_data[i]["latitude"]).indexOf(latitude) <= 0) {
                            search_query_data.splice(i, 1);
                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {
                        if (("_" + jsonData[i]["latitude"]).indexOf(latitude) > 0) {
                            search_query_data.push(jsonData[i]);

                        }
                    }
                }
            }
            if (longitude != null) {
                if (search_query_data.length > 0) {
                    for (var i = 0; i < search_query_data.length; i++) {
                        if (("_" + search_query_data[i]["longitude"]).indexOf(longitude) <= 0) {
                            search_query_data.splice(i, 1);
                        }
                    }
                } else {
                    for (var i = 0; i < jsonData.length; i++) {
                        if (("_" + jsonData[i]["longitude"]).indexOf(longitude) > 0) {
                            search_query_data.push(jsonData[i]);

                        }
                    }
                }
            }
            if (search_query_data.length == 0) {
                search_query_data = jsonData;
                alert('No data found!Load default data.');
            }
            return search_query_data;
        }
       
    </script>

</head>
<body>
    <form id="form1"  >
        <div class="site-header site-header-primary hk-en-pos">

            <div class="cols-row" role="banner"> 
                <a id="header-logo" class="logo hk-en-pos" href="http://www.expedia.com.hk/ " target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.ExpediaLogo')" data-tid="header-logo">Expedia.com.hk</a>

                <ul class="mobile-language-links cf"> 
                    <!-- jdbk-test (languageLinks): domain: www.expedia.com.hk - request.serverName: www.expedia.com.hk -->
                    <li id="language-link-3076" class="language-toggle"><a id="header-language-3076" class="nav-tab" href="//www.expedia.com.hk/Flights-SearchResults-RoundTrip?langid=3076" rel="nofollow" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.LanguageLink');langRedirectionUrl(this);return false;">繁體中文 </a></li>
                    <li id="language-link-2052" class="language-toggle"><a id="header-language-2052" class="nav-tab" href="//www.expedia.com.hk/Flights-SearchResults-RoundTrip?langid=2052" rel="nofollow" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.LanguageLink');langRedirectionUrl(this);return false;">简体中文 </a></li>
                </ul> 
                <!-- Responsive Menu Toggle -->
                <label id="mobile-toggle-header-link" class="btn off-canvas-btn menu-toggle-btn" for="menuToggle">
                    <span id="header-mobile-toggle" class="icon icon-offcanvas"></span>
                </label>
                <input id="menuToggle" class="hidden toggle-checkbox" value="show menu" type="checkbox">
                <!-- / End Responsive Menu Toggle -->

                <div id="globalSiteNavigation" class="site-navigation cf" role="navigation">
                    <ul class="utility-nav below726 nav-group cf">
                        <li id="shop-menu"><a id="header-shop-menu" class="nav-tab" href="#shop-menu" data-onclick="xp.nav.trackAnalytics(this,'a','Header.ShopHeading'); return false;" data-tid="header-shop-menu" data-control="menu">Shop Travel<span class="icon icon-toggle180"></span> </a>
                            <div class="menu">
                                <ul>
                                    <!-- jdbk-test (shopMenuLinks): domain: www.expedia.com.hk - request.serverName: www.expedia.com.hk -->
                                    <li><a id="sub-menu-header-shop-home" href="//www.expedia.com.hk/" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Home')">Home </a></li>
                                    <li><a id="sub-menu-header-shop-hotel" href="//www.expedia.com.hk/en/Hotels" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Hotels')">Hotels </a></li>
                                    <li><a id="sub-menu-header-shop-flight" href="//www.expedia.com.hk/en/Flights" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Flights')">Flights </a></li>
                                    <li><a id="sub-menu-header-shop-package" href="//www.expedia.com.hk/en/Packages" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.VacationPackages')">Flights + Hotels </a></li>
                                    <li><a id="sub-menu-header-shop-cars" href="//www.expedia.com.hk/Car-Rental" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Cars')">Car Rental </a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <ul class="shop-nav nav-group cf">





                        <!-- jdbk-test (languageLinks): domain: www.expedia.com.hk - request.serverName: www.expedia.com.hk -->
                        <li id="language-link-3076" class="language-toggle"></li>
                    </ul>
                </div>
                <!-- /.site-navigation -->
            </div>
            <!-- /.cols-row role="banner" -->


            <div class="cols-row cf secondary-branding-container">
                <div class="secondary-branding">
                    <img border="0" src="//media.expedia.com/media/content/expind/images/homepage/theworldlargestcompany-in.png" width="305" height="28">
                </div>
            </div>
        </div>

        <div class="site-header site-header-secondary">
            <div class="cols-row">
                <!-- home -->
                <div class="site-navigation all-in cf">
                    <ul class="utility-nav nav-group cf">

                        <li id="all-in-home-header-link">
                            <a id="primary-header-home" href="//www.expedia.com.hk/" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Home')">Home </a></li>
                        <li id="all-in-hotel-header-link" class="selected-tab "><a id="primary-header-hotel" href="#" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Hotels')">Hotels </a></li>
                        <li id="all-in-flight-header-link"><a id="primary-header-flight" href="//www.expedia.com.hk/en/Flights" target="_top" data-onclick="xp.nav.trackAnalytics(this,'a','Header.Flights')">Flights </a></li>
                        <li id="all-in-package-header-link"><a id="primary-header-package" href="//www.expedia.com.hk/en/Packages" target="_top">Flights + Hotels </a></li>
                        <li id="all-in-cars-header-link"><a id="primary-header-cars" href="//www.expedia.com.hk/Car-Rental" target="_top">Car Rental </a></li>
                    </ul>
                </div>
                <!-- /.site-navigation all-in -->

                <!-- end if block for !model.isBlank -->

            </div>
            <!-- /.cols-row role="banner" -->
        </div>
        <div class="xp-grd-ctn xp-grd-widget xp-b-clearfix" id="xp_hp_contentContainer">
            <div id="container" class="xp-b-clearfix xp-pl-widget">
                <input id="uw_wizardstate" name="uw_wizardstate" value="" type="hidden">
                <div class="xp-w-rnd-out-top"><span>
                    <!-- -->
                </span></div>
                <div id="xp_uw_cnt-out" class="xp-w-rnd-out-cnt">
                    <h1>BOOK YOUR TRAVEL</h1>
                    <div class="xp-w-rnd-inn-top"><span>
                        <!-- -->
                    </span></div>
                    <div id="xp_uw_cnt-inn" class="xp-w-rnd-inn-cnt">
                        <div id="xp_uw_topContainer" class="xp-w-bx-cnt-inn-top xp-b-clearfix">
                            <p id="xp_uw_ajaxErrorContainer" class="errorMessage xp-b-noXpend">Sorry,we had a problem. Please try again.</p>
                            <div id="xp_uw_lobContainer" class="xp-w-bx-cnt-lob">
                                <div class="xp-w-lob-pos">
                                    <div style="visibility: visible;" id="existing_upsell">
                                        <div class="wizard-tag">
                                            <div id="wizardBPG">
                                                <img border="0" alt="Book Flight &amp; Hotel together and Save up to 30% extra" src="//media.expedia.com/media/content/exphk/images/home/dynamic/wizard_tag_hk_en_package.png" width="196" height="131">
                                            </div>
                                            <div style="display: none;" id="wizardTag">
                                                <img border="0" alt="Book Flight &amp; Hotel together and Save up to 30% extra" src="//media.expedia.com/media/content/exphk/images/home/dynamic/wizard_tag_hk_en_package.png" width="196" height="131">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <ul class="xp-w-lob-sa">
                                    <li>
                                        <div class="xp-b-clearfix">
                                            <input id="hot-only" class="wizardRadio xp-b-left" name="srch" checked="" type="radio" wizardtype="hotelOnly">
                                            <label id="hot-only-label" class="xp-b-left xp-w-label-lob" for="hot-only">
                                                Hotel
                                            </label>
                                        </div>
                                    </li>



                                </ul>
                                <div class="xp-w-lob-pac">
                                    <div class="xp-w-lobTL">
                                        <!-- -->
                                    </div>
                                    <div class="xp-w-lobBL">
                                        <!-- -->
                                    </div>
                                    <div class="xp-w-lobTR">
                                        <!-- -->
                                    </div>
                                    <div class="xp-w-lobBR">
                                        <!-- -->
                                    </div>
                                    <ul>
                                    </ul>
                                </div>
                            </div>
                        </div>


                        <div id="xp_uw_bottomContainer" class="xp-w-bx-cnt-inn-bot xp-b-clearfix">

                            <div id="xp_uw_form" class="xp-b-clearfix">

                                <div id="hot-content">

                                    <div style="display: block;" id="hot-add-div" class="xp-b-noXpend">


                                        <div id="hot-sear-date-check-in" class="xp-w-cell xp-w-cell-small">
                                            <label id="hot-check-in-label" for="hot-check-in">Check-in:</label>
                                            <input id="checkInDate" style="width:60px"  name="hotelSearchWizard_inpCheckIn" maxlength="12" value="yyyy/mm/dd" type="text" required="false" date="true" datemessage="dateFormatMessage" priortocurrentdate="true" format="allow" priortocurrentdatemessage="priorToCurrentDateMessage">
                                        </div>

                                        <div id="hot-sear-date-check-out" class="xp-w-cell xp-w-cell-small">
                                            <label id="hot-check-out-label" for="hot-check-out">Check-out:</label>
                                            <input id="checkOutDate"   style="width:60px" name="hotelSearchWizard_inpCheckOut" maxlength="12" value="yyyy/mm/dd" type="text" required="false" date="true" datemessage="dateFormatMessage" priortocurrentdate="true" format="allow" priortocurrentdatemessage="priorToCurrentDateMessage" aftermessage="dateSequenceMessage" after="hot-check-in">
                                        </div>


                                        <div class="xp-b-clearfix xp-w-row ">
                                              <div id="hot-hot-name-container" class="xp-w-cell xp-w-cell-half">
                                                <label id="hot-hot-name-label" for="hot-hot-name">Province :</label>
                                                <input id="province" name="hotelSearchWizard_inpProvince" maxlength="80" value="" type="text">
                                            </div>
                                            <div class="xp-w-cell xp-w-cell-half">
                                                <label for="hot-hot-name">City Name:</label>
                                                <input id="hot-hot-cityname" name="hotelSearchWizard_inpCityName" maxlength="80" value="" type="text">
                                            </div>
                                            <div id="hot-hot-name-container" class="xp-w-cell xp-w-cell-half">
                                                <label id="hot-hot-name-label" for="hot-hot-name">Hotel Name:</label>
                                                <input id="hot-hot-name" name="hotelSearchWizard_inpHotelName" maxlength="80" value="" type="text">
                                            </div>
                                            <div class="xp-w-cell xp-w-cell-half">
                                                <label for="hot-hot-name">Street Address:</label>
                                                <input id="hot-hot-streetaddress" name="hotelSearchWizard_inpstreetaddress" maxlength="80" value="" type="text">
                                            </div>
                                            <div class="xp-w-cell xp-w-cell-half">
                                                <label for="hot-hot-name">Latitude:</label>
                                                <input id="hot-hot-latitude" name="hotelSearchWizard_inpLatitude" maxlength="80" value="" type="text">
                                            </div>

                                            <div class="xp-w-cell xp-w-cell-half">
                                                <label for="hot-hot-name">Longitude:</label>
                                                <input id="hot-hot-longtitude" name="hotelSearchWizard_inplongtitude" maxlength="80" value="" type="text">
                                            </div>

                                            <div class="xp-w-cell xp-w-cell-half xp-w-cell-last">
                                                <label id="hot-class-label" for="hot-class">Hotel Class:</label>
                                                <select id="hot-startrate" name="hotelSearchWizard_inpHotelClass">
                                                    <option value="0">Show All</option>

                                                    <option value="10">1 Star or More</option>

                                                    <option value="20">2 Stars or More</option>

                                                    <option value="30">3 Stars or More</option>

                                                    <option value="40">4 Stars or More</option>

                                                    <option value="50">5 Stars</option>

                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <p id="hot-submit" class="xp-b-clearfix uw-submit-button">
                                        <span class="xp-b-right">
                                            <span class="xp-b-leftSubmit2">
                                                <!-- -->
                                            </span>
                                            <a id="hot-sub-anc" class="xp-b-submit2" onclick="SearchHotel();" href="#"><span id="hot-button-text-normal">Search For Hotels</span><span style="display: none;" id="hot-button-text-nine">Request 9+ hotel rooms</span></a>
                                            <span class="xp-b-rightSubmit2">
                                                <!-- -->
                                            </span>
                                        </span>
                                    </p>

                                </div>





                            </div>

                        </div>
                    </div>
                </div>

                <div class="xp-w-rnd-out-bot">
                  
                    <span>
                        <!-- -->
                    </span>
                </div>

                 
            </div>
            <span id="datainfor" style="padding:5px; display:none"></span>
              <table id="searchdata" class="segmented-list easyui-datagrid" style="width: 956px; height: auto; display:none"
            data-options=" 
				data: jsonData, 
                showHeader: 'true',
                showFooter: 'true',
                pageSize:20,
                  pagePosition:'bottom'
			">
            <thead>
                <tr>
                     <th data-options="field:'imageUrl',width:'120',height:'80', align:'center',formatter: function(value,row,index){
                         if(value!='')
                         {
				 return '<a target=_blank border=0 href='+row.dealDeepLink+'> <img class=thumnail src='+value+' ></a>';
                         }}"
                         ></th>
                    <th data-options="field:'movingAverageScore',hidden: 'true'">movingAverageScore</th>
                    <th data-options="field:'rawAppealScore', hidden: 'true'">rawAppealScore</th>
                    <th data-options="field:'relevanceScore',hidden: 'true'">relevanceScore</th>
                     <th data-options="field:'country',align:'center' ,width:'50'">Country</th>
                    <th data-options="field:'userCity', align:'right' ">User City</th>
                     <th data-options="field:'province',align:'center' ">Province</th>
                    <th data-options="field:'userOrigin', hidden: 'true'">userOrigin</th>
                    <th data-options="field:'checkInDate',align:'center' ">Check In Date</th>
                     <th data-options="field:'checkOutDate',align:'center' ">Check Out Date</th>
                     <th data-options="field:'hotelId',align:'center',hidden: 'true'">hotelId</th>
                     <th data-options="field:'name',align:'center',width:'120' ">name</th>
                     <th data-options="field:'streetAddress',align:'center' ">Address</th>
                          <th data-options="field:'latitude',align:'center' ">Latitude</th>
                     <th data-options="field:'longitude',align:'center' ">Longitude</th>
                     <th data-options="field:'city',align:'center',hidden: 'true'">City</th>
                    
                    
               
                     <th data-options="field:'description',align:'center',hidden: 'true'">description</th>
                     <th data-options="field:'destination',align:'center',hidden: 'true'">destination</th>
                     <th data-options="field:'longDestinationName',align:'center',hidden: 'true'">longDestinationName</th>
                     <th data-options="field:'regionId',align:'center',hidden: 'true'">regionId</th>
                     <th data-options="field:'pricePerNight',align:'center' ">Price/Night</th>
                     <th data-options="field:'originalPricePerNight',align:'center'">Original Price/Night</th>
                 
                     
                      <th data-options="field:'currency',align:'center'">Currency</th>
                      <th data-options="field:'starRating',align:'center'">Star Rating</th>
                      <th data-options="field:'totalRate',align:'center',hidden: 'true'">totalRate</th>
                     <th data-options="field:'dealDeepLink',align:'center',hidden: 'true'">dealDeepLink</th>
                    
                </tr>
            </thead>
        </table>
        </div>
       
     
    </form>

</body>
    
</html>
