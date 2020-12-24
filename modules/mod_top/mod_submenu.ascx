<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_submenu.ascx.cs" Inherits="modules_mod_top_mod_submenu" %>
<%@ Import Namespace="System.Data" %>
<div class="wrap-breadcrumb">
    <div class="clearfix container">
        <div class="row main-header">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 pd5  ">
                <ol class="breadcrumb breadcrumb-arrows">
                    <li><a href="<%= clsConfig.GetHostUrl() %>" target="_self">Trang chủ</a></li>
                    <li><a href="/collections/dong-ho-chong-nuoc" target="_self">Đồng hồ nổi bật</a></li>
                    <li class="active"><span>ĐỒNG HỒ NAM TEVISE 1952 CHẠY CƠ CỰC CHẤT</span></li>
                </ol>
            </div>
        </div>
    </div>
</div>
