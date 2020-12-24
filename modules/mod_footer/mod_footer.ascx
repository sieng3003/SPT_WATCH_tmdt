<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_footer.ascx.cs" Inherits="modules_mod_footer_mod_footer" %>
<%@ Import Namespace="System.Data" %>
<%
    DataTable dtInfo = clsDatabase.getDataTable("select TOP 1 * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
    DataTable dsMenu = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and C_MenuNgang=1 and FK_ParentID=0 and C_Active = 1  order by C_Rank desc");
%>
<div class="footer-bottom">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-md-3 col-xs-12 clear-sm">
                <div class="widget-wrapper animated">
                    <h3 class="title title_left">
                        Giới thiệu</h3>
                    <div class="inner about_us">
                        <p class="message">
                            <%=clsInput.decodeStr(dtInfo.Rows[0]["GioiThieu1"].ToString())%>
                        </p>
                        <ul class="list-unstyled">
                            <li><i class="fa fa-home"></i>
                                <%=dtInfo.Rows[0]["DiaChi"].ToString()%>
                            </li>
                            <li><i class="fa fa-envelope-o"></i><a href="mailto: <%=dtInfo.Rows[0]["Email"].ToString()%>">
                                <%=dtInfo.Rows[0]["Email"].ToString()%></a> </li>
                            <li><i class="fa fa-phone"></i>
                                <%=dtInfo.Rows[0]["DienThoai"].ToString()%>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-2 col-xs-12 clear-sm">
                <div class="widget-wrapper animated">
                    <h3 class="title title_left">
                        Liên kết</h3>
                    <div class="inner">
                        <%if (dsMenu.Rows.Count > 0)
                          {%>
                        <ul class="list-unstyled list-styled">
                            <%foreach (DataRow itemMenu in dsMenu.Rows)
                              {
              
                            %>
                            <li><a href="<%= clsConfig.GetHostUrl() %>/<%=itemMenu["C_Url"].ToString() %>">
                                <%=itemMenu["C_Name"].ToString() %></a> </li>
                            <%} %>
                        </ul>
                        <%} %>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3 col-xs-12 clear-sm">
                <div class="widget-wrapper animated">
                    <h3 class="title title_left">
                        Đăng kí nhận tin</h3>
                    <div class="inner">
                        <form accept-charset='UTF-8' action='#' class='contact-form' method='post'>
                        <input name='form_type' type='hidden' value='customer'>
                        <input name='utf8' type='hidden' value='✓'>
                        <div class="group-input">
                            <input type="hidden" id="contact_tags" name="contact[tags]" value="khách hàng tiềm năng, bản tin" />
                            <input type="email" required="required" name="contact[email]" id="contact_email" />
                            <span class="bar"></span>
                            <label>
                                Nhập email của bạn</label>
                            <button type="submit">
                                <i class="fa fa-paper-plane-o"></i>
                            </button>
                        </div>
                        </form>
                        <div class="caption">
                            Hãy nhập email của bạn vào đây để nhận tin!</div>
                    </div>
                    <div id="widget-social" class="social-icons">
                        <ul class="list-inline">
                            <li><a target="_blank" href="#" class="social-wrapper facebook"><span class="social-icon">
                                <i class="fa fa-facebook"></i></span></a></li>
                            <li><a target="_blank" href="#" class="social-wrapper twitter"><span class="social-icon">
                                <i class="fa fa-twitter"></i></span></a></li>
                            <li><a target="_blank" href="#" class="social-wrapper pinterest"><span class="social-icon">
                                <i class="fa fa-pinterest"></i></span></a></li>
                            <li><a target="_blank" href="#" class="social-wrapper google"><span class="social-icon">
                                <i class="fa fa-google-plus"></i></span></a></li>
                            <li><a target="_blank" href="#" class="social-wrapper youtube"><span class="social-icon">
                                <i class="fa fa-youtube"></i></span></a></li>
                            <li><a target="_blank" href="#" class="social-wrapper instagram"><span class="social-icon">
                                <i class="fa fa-instagram"></i></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4 col-xs-12 clear-sm">
                <div class="widget-wrapper animated">
                    <h3 class="title title_left">
                        Kết nối với chúng tôi</h3>
                    <div class="inner">
                        <%--<iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FTh%C6%A1-B%C3%BAt-Tre-v%C3%A0-%C4%91%E1%BB%91-t%E1%BB%A5c-gi%E1%BA%A3ng-thanh-243410605697293%2F&tabs=timeline&width=340&height=180&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId"
                            width="340" height="180" style="border: none; overflow: hidden" scrolling="no"
                            frameborder="0" allowtransparency="true"></iframe>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer-copyright">
    <div class="container copyright">
        <p>
            <%=dtInfo.Rows[0]["C_Copyright"].ToString()%></p>
    </div>
</div>
