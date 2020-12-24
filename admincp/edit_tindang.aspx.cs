using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class admincp_edit_tindang : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //========================
        clsConfig.Xacnhandangnhap();
        //========================
        int intID = clsInput.getNumericInput("id", 0);


        if (!IsPostBack)
        {


            //=================================================================
            //Lay thong tin ban ghi
            int FK_LoaitinraoID = 0;
            int FK_LoaidiaocID = 0;
            int FK_Loaidiaoc1ID = 0;
            int FK_TinhthanhID = 0;
            int FK_QuanhuyenID = 0;
            int FK_PhuongxaID = 0;
            string C_Diachi = "";
            int FK_TenduanID = 0;
            string C_Gia = "";
            long intGia = 0;
            int FK_LoaitienteID = 0;
            int FK_LoaidientichID = 0;
            int FK_MoigioiID = 0;
            string C_Dientichsudung = "";
            string C_Dientichdat = "";
            string C_Dientichkhuonvien_dai = "";
            string C_Dientichkhuonvien_rong = "";
            string C_Dientichkhuonvien_rongsau = "";
            string C_Dientichxaydung_dai = "";
            string C_Dientichxaydung_rong = "";
            string C_Dientichxaydung_rongsau = "";
            int FK_TinhtrangphaplyID = 0;
            int FK_SophongkhachID = 0;
            int FK_HuongtaisanID = 0;
            int FK_SophongnguID = 0;
            int FK_DuongtruocnhaID = 0;
            int FK_SophongtamID = 0;
            int FK_SolauID = 0;
            int FK_SophongkhacID = 0;
            int C_Daydutiennghi = 0;
            int C_Chodauxehoi = 0;
            int C_Sanvuon = 0;
            int C_Hoboi = 0;
            int C_Tienkinhdoanh = 0;
            int C_Tiendeo = 0;
            int C_Tienlamvanphong = 0;
            int C_Tienchosanxuat = 0;
            int C_Tienchosinhvienthue = 0;
            string C_Tieude = "";
            string C_Noidung = "";
            string C_Google_X = "";
            string C_Google_Y = "";
            string C_File1 = "";
            string C_File2 = "";
            string C_File3 = "";
            string C_File4 = "";
            string C_File5 = "";
            string C_Nguoilienhe = "";
            string C_Dienthoai = "";
            string C_Didong = "";
            string C_Diachilienhe = "";
            string C_Ghichu = "";
            int C_Vip = 0;
            int C_Chungthuc = 0;
            int C_Star = 0;
            int C_Active = 0;

            string C_Duankhac = "";
            int intCheckDuankhac = 0;

            DataTable dtEdit = clsDatabase.getDataTable("select TOP 1 * from tbl_tindang where PK_TindangID = " + intID );
            if (dtEdit.Rows.Count > 0)
            {
                FK_LoaitinraoID = Convert.ToInt32(dtEdit.Rows[0]["FK_LoaitinraoID"].ToString());
                FK_LoaidiaocID = Convert.ToInt32(dtEdit.Rows[0]["FK_LoaidiaocID"].ToString());
                //FK_Loaidiaoc1ID = Convert.ToInt32(dtEdit.Rows[0]["FK_Loaidiaoc1ID"].ToString());
                FK_TinhthanhID = Convert.ToInt32(dtEdit.Rows[0]["FK_TinhthanhID"].ToString());
                FK_QuanhuyenID = Convert.ToInt32(dtEdit.Rows[0]["FK_QuanhuyenID"].ToString());
                FK_PhuongxaID = Convert.ToInt32(dtEdit.Rows[0]["FK_PhuongxaID"].ToString());

                C_Diachi = clsInput.decodeStr(dtEdit.Rows[0]["C_Diachi"].ToString());
                FK_TenduanID = Convert.ToInt32(dtEdit.Rows[0]["FK_TenduanID"].ToString());
                C_Gia = clsInput.decodeStr(dtEdit.Rows[0]["C_Gia"].ToString());
                intGia = Convert.ToInt64(C_Gia);
                intGia = intGia / 1000000;
                FK_LoaitienteID = Convert.ToInt32(dtEdit.Rows[0]["FK_LoaitienteID"].ToString());
                FK_LoaidientichID = Convert.ToInt32(dtEdit.Rows[0]["FK_LoaidientichID"].ToString());
                FK_MoigioiID = Convert.ToInt32(dtEdit.Rows[0]["FK_MoigioiID"].ToString());
                C_Dientichsudung = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichsudung"].ToString());
                C_Dientichdat = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichdat"].ToString());
                C_Dientichkhuonvien_dai = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichkhuonvien_dai"].ToString());
                C_Dientichkhuonvien_rong = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichkhuonvien_rong"].ToString());
                C_Dientichkhuonvien_rongsau = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichkhuonvien_rongsau"].ToString());
                C_Dientichxaydung_dai = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichxaydung_dai"].ToString());
                C_Dientichxaydung_rong = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichxaydung_rong"].ToString());
                C_Dientichxaydung_rongsau = clsInput.decodeStr(dtEdit.Rows[0]["C_Dientichxaydung_rongsau"].ToString());
                FK_TinhtrangphaplyID = Convert.ToInt32(dtEdit.Rows[0]["FK_TinhtrangphaplyID"].ToString());
                FK_SophongkhachID = Convert.ToInt32(dtEdit.Rows[0]["FK_SophongkhachID"].ToString());
                FK_HuongtaisanID = Convert.ToInt32(dtEdit.Rows[0]["FK_HuongtaisanID"].ToString());
                FK_SophongnguID = Convert.ToInt32(dtEdit.Rows[0]["FK_SophongnguID"].ToString());
                FK_DuongtruocnhaID = Convert.ToInt32(dtEdit.Rows[0]["FK_DuongtruocnhaID"].ToString());
                FK_SophongtamID = Convert.ToInt32(dtEdit.Rows[0]["FK_SophongtamID"].ToString());
                FK_SolauID = Convert.ToInt32(dtEdit.Rows[0]["FK_SolauID"].ToString());
                FK_SophongkhacID = Convert.ToInt32(dtEdit.Rows[0]["FK_SophongkhacID"].ToString());

                C_Daydutiennghi = Convert.ToInt32(dtEdit.Rows[0]["C_Daydutiennghi"].ToString());
                C_Chodauxehoi = Convert.ToInt32(dtEdit.Rows[0]["C_Chodauxehoi"].ToString());
                C_Sanvuon = Convert.ToInt32(dtEdit.Rows[0]["C_Sanvuon"].ToString());
                C_Hoboi = Convert.ToInt32(dtEdit.Rows[0]["C_Hoboi"].ToString());
                C_Tienkinhdoanh = Convert.ToInt32(dtEdit.Rows[0]["C_Tienkinhdoanh"].ToString());
                C_Tiendeo = Convert.ToInt32(dtEdit.Rows[0]["C_Tiendeo"].ToString());
                C_Tienlamvanphong = Convert.ToInt32(dtEdit.Rows[0]["C_Tienlamvanphong"].ToString());
                C_Tienchosanxuat = Convert.ToInt32(dtEdit.Rows[0]["C_Tienchosanxuat"].ToString());
                C_Tienchosinhvienthue = Convert.ToInt32(dtEdit.Rows[0]["C_Tienchosinhvienthue"].ToString());



                C_Tieude = clsInput.decodeStr(dtEdit.Rows[0]["C_Tieude"].ToString());
                C_Noidung = clsInput.decodeStr(dtEdit.Rows[0]["C_Noidung"].ToString());
                C_Nguoilienhe = clsInput.decodeStr(dtEdit.Rows[0]["C_Nguoilienhe"].ToString());
                C_Dienthoai = clsInput.decodeStr(dtEdit.Rows[0]["C_Dienthoai"].ToString());
                C_Didong = clsInput.decodeStr(dtEdit.Rows[0]["C_Didong"].ToString());
                C_Diachilienhe = clsInput.decodeStr(dtEdit.Rows[0]["C_Diachilienhe"].ToString());
                C_Ghichu = clsInput.decodeStr(dtEdit.Rows[0]["C_Ghichu"].ToString());


                C_Vip = Convert.ToInt32(dtEdit.Rows[0]["C_Vip"].ToString());
                C_Chungthuc = Convert.ToInt32(dtEdit.Rows[0]["C_Chungthuc"].ToString());
                C_Star = Convert.ToInt32(dtEdit.Rows[0]["C_Star"].ToString());
                C_Active = Convert.ToInt32(dtEdit.Rows[0]["C_Active"].ToString());

                C_Duankhac = clsInput.decodeStr(dtEdit.Rows[0]["C_Duankhac"].ToString());
                intCheckDuankhac = Convert.ToInt32(dtEdit.Rows[0]["C_Checkduankhac"].ToString());


                txtDuankhac.Text = C_Duankhac;
                if (intCheckDuankhac == 1)
                    chkDuankhac.Checked = true;
                

                if (C_Vip == 1)
                    chkVip.Checked = true;
                if (C_Chungthuc == 1)
                    chkChungthuc.Checked = true;
                if (C_Active == 1)
                    chkActive.Checked = true;

                drdStar.SelectedIndex = C_Star;



                //=================================================================
                //bind thong tin
                //Response.Write(FK_LoaitinraoID.ToString());
                //Kiem tra loai tin rao
                if (FK_LoaitinraoID == 1)
                    rdoLoaitinrao.SelectedIndex = 0;
                if (FK_LoaitinraoID == 2)
                    rdoLoaitinrao.SelectedIndex = 1;
                if (FK_LoaitinraoID == 3)
                    rdoLoaitinrao.SelectedIndex = 2;
                if (FK_LoaitinraoID == 4)
                    rdoLoaitinrao.SelectedIndex = 3;
                if (FK_LoaitinraoID == 5)
                    rdoLoaitinrao.SelectedIndex = 4;

                bindLoaidiaoc(FK_LoaidiaocID);
                //bindLoaidiaoc1(FK_Loaidiaoc1ID);
                //bindTinhthanh();
                bindTenduan(FK_TenduanID);
                bindHuong(FK_HuongtaisanID);
                bindPhaply(FK_TinhtrangphaplyID);


                txtDiachi.Text = C_Diachi;
                txtGia.Text = intGia.ToString();
                

                if (FK_LoaidientichID == 1)
                    drdLoaidientich.SelectedIndex = 0;
                if (FK_LoaidientichID == 2)
                    drdLoaidientich.SelectedIndex = 1;
                if (FK_LoaidientichID == 3)
                    drdLoaidientich.SelectedIndex = 2;

                if (FK_MoigioiID == 1)
                    rdoMoigioi.SelectedIndex = 0;
                if (FK_MoigioiID == 2)
                    rdoMoigioi.SelectedIndex = 1;

                txtDientichsudung.Text = C_Dientichsudung;
                txtDientichdat.Text = C_Dientichdat;
                txtDientichkhuonvien_dai.Text = C_Dientichkhuonvien_dai;
                txtDientichkhuonvien_rong.Text = C_Dientichkhuonvien_rong;
                txtDientichkhuonvien_rongsau.Text = C_Dientichkhuonvien_rongsau;
                txtDientichxaydung_dai.Text = C_Dientichxaydung_dai;
                txtDientichxaydung_rong.Text = C_Dientichxaydung_rong;
                txtDientichxaydung_rongsau.Text = C_Dientichxaydung_rongsau;

                if (C_Daydutiennghi == 1)
                    chkDaydutiennghi.Checked = true;
                if (C_Chodauxehoi == 1)
                    chkChodauxehoi.Checked = true;
                if (C_Sanvuon == 1)
                    chkSanvuon.Checked = true;
                if (C_Hoboi == 1)
                    chkHoboi.Checked = true;
                if (C_Tienkinhdoanh == 1)
                    chkTienkinhdoanh.Checked = true;
                if (C_Tiendeo == 1)
                    chkTiendeo.Checked = true;
                if (C_Tienlamvanphong == 1)
                    chkTienlamvanphong.Checked = true;
                if (C_Tienchosanxuat == 1)
                    chkTienchosanxuat.Checked = true;
                if (C_Tienchosinhvienthue == 1)
                    chkTienchosinhvienthue.Checked = true;

                drdTinhtrangphaply.SelectedIndex = FK_TinhtrangphaplyID;
                drdHuongtaisan.SelectedIndex = FK_HuongtaisanID;
                drdDuongtruocnha.SelectedIndex = FK_DuongtruocnhaID;


                txtSophongkhach.Text = FK_SophongkhachID.ToString();
                txtSophongngu.Text = FK_SophongnguID.ToString();
                txtSophongtam.Text = FK_SophongtamID.ToString();
                txtSophongkhac.Text = FK_SophongkhacID.ToString();
                txtSolau.Text = FK_SolauID.ToString();

                txtTieude.Text = C_Tieude;
                txtNoidung.Text = C_Noidung;

                txtNguoilienhe.Text = C_Nguoilienhe;
                txtDienthoai.Text = C_Dienthoai;
                txtDidong.Text = C_Didong;
                txtDiachilienhe.Text = C_Diachilienhe;
                txtGhichu.Text = C_Ghichu;

                

                //=================================================================

                this.loadPopulateTinhthanh(FK_TinhthanhID);
                this.loadPopulateQuanhuyen(FK_TinhthanhID, FK_QuanhuyenID);
                this.loadPopulateTenduan(FK_QuanhuyenID, FK_TenduanID);
            }
            else
                Response.Redirect(clsConfig.GetHostUrl() + "/thanh-vien/quan-ly-tin-dang/home.aspx");

        }




        inc_top.Controls.Add(LoadControl("modules/mod_top/mod_top.ascx"));
        


    }
    private bool checkNguoiviettin(int intID)
    {
        DataTable dt = clsDatabase.getDataTable("select TOP 1 PK_TindangID, FK_UserID from tbl_tindang where PK_TindangID = " + intID);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["FK_UserID"].ToString() != "")
            {
                if (Convert.ToInt32(dt.Rows[0]["FK_UserID"]) == Convert.ToInt32(this.Session["Front_UserID"].ToString()))
                    return true;
            }
        }
        return false;
    }


    private void bindPhaply(int FK_PhaplyID)
    {
        drdTinhtrangphaply.Items.Insert(0, new ListItem("Chọn dự án...", "0"));
        int intSelected = 1;
        DataTable dtPhaply = clsDatabase.getDataTable("select PK_PhaplyID, C_Name from tbl_phaply where C_Active =1 order by C_Rank desc");
        for (int intPhaply = 0; intPhaply < dtPhaply.Rows.Count; intPhaply++)
        {
            drdTinhtrangphaply.Items.Add(new ListItem(dtPhaply.Rows[intPhaply]["C_Name"].ToString(), dtPhaply.Rows[intPhaply]["PK_PhaplyID"].ToString()));
            if (Convert.ToInt32(dtPhaply.Rows[intPhaply]["PK_PhaplyID"].ToString()) == FK_PhaplyID)
                drdTinhtrangphaply.SelectedIndex = intSelected;
            intSelected++;
        }
    }

    private void bindHuong(int FK_HuongID)
    {
        drdHuongtaisan.Items.Insert(0, new ListItem("Chọn hướng tài sản...", "0"));
        int intSelected = 1;
        DataTable dtHuong = clsDatabase.getDataTable("select PK_HuongID, C_Name from tbl_huong where C_Active =1 order by C_Rank desc");
        for (int intHuong = 0; intHuong < dtHuong.Rows.Count; intHuong++)
        {
            drdHuongtaisan.Items.Add(new ListItem(dtHuong.Rows[intHuong]["C_Name"].ToString(), dtHuong.Rows[intHuong]["PK_HuongID"].ToString()));
            if (Convert.ToInt32(dtHuong.Rows[intHuong]["PK_HuongID"].ToString()) == FK_HuongID)
                drdHuongtaisan.SelectedIndex = intSelected;
            intSelected++;
        }
    }


    private void loadPopulateTinhthanh(int FK_TinhthanhID)
    {
        DataTable dtbdsTinhthanh = clsDatabase.getDataTable("select PK_bdsTinhthanhID, C_Name from tbl_bdsTinhthanh where C_Active =1 order by C_Rank desc");
        int intSelected = 0;

        for (int intbdsTinhthanh = 0; intbdsTinhthanh < dtbdsTinhthanh.Rows.Count; intbdsTinhthanh++)
        {
            intSelected++;
            drdTinhthanh.Items.Add(new ListItem(dtbdsTinhthanh.Rows[intbdsTinhthanh]["C_Name"].ToString(), dtbdsTinhthanh.Rows[intbdsTinhthanh]["PK_bdsTinhthanhID"].ToString()));
            if (Convert.ToInt32(dtbdsTinhthanh.Rows[intbdsTinhthanh]["PK_bdsTinhthanhID"].ToString()) == FK_TinhthanhID)
                drdTinhthanh.SelectedIndex = intSelected;
        }

    }
    private void loadPopulateQuanhuyen(int FK_TinhthanhID, int FK_QuanhuyenID)
    {
        DataTable dtbdsQuanhuyen = clsDatabase.getDataTable("select PK_bdsQuanhuyenID, C_Name from tbl_bdsQuanhuyen where C_Active =1 and FK_bdsTinhthanhID = " + FK_TinhthanhID + " order by C_Rank desc");
        int intSelected = 0;

        for (int intbdsQuanhuyen = 0; intbdsQuanhuyen < dtbdsQuanhuyen.Rows.Count; intbdsQuanhuyen++)
        {
            intSelected++;
            drdQuanhuyen.Items.Add(new ListItem(dtbdsQuanhuyen.Rows[intbdsQuanhuyen]["C_Name"].ToString(), dtbdsQuanhuyen.Rows[intbdsQuanhuyen]["PK_bdsQuanhuyenID"].ToString()));
            if (Convert.ToInt32(dtbdsQuanhuyen.Rows[intbdsQuanhuyen]["PK_bdsQuanhuyenID"].ToString()) == FK_QuanhuyenID)
            {
                drdQuanhuyen.SelectedIndex = intSelected;
                //Response.Write(FK_QuanhuyenID.ToString());
            }
        }
    }
    private void loadPopulateTenduan(int FK_QuanhuyenID, int FK_TenduanID)
    {
        DataTable dtbdsTenduan = clsDatabase.getDataTable("select PK_bdsDuanID, C_Name from tbl_bdsDuan where C_Active =1 and FK_QuanhuyenID = " + FK_QuanhuyenID + " order by C_Rank desc");
        int intSelected = 0;
        drdTenduan.Items.Clear();
        for (int intbdsTenduan = 0; intbdsTenduan < dtbdsTenduan.Rows.Count; intbdsTenduan++)
        {
            intSelected++;
            drdTenduan.Items.Add(new ListItem(dtbdsTenduan.Rows[intbdsTenduan]["C_Name"].ToString(), dtbdsTenduan.Rows[intbdsTenduan]["PK_bdsDuanID"].ToString()));
            if (Convert.ToInt32(dtbdsTenduan.Rows[intbdsTenduan]["PK_bdsDuanID"].ToString()) == FK_TenduanID)
                drdTenduan.SelectedIndex = intSelected;
        }
    }

    [System.Web.Services.WebMethod]
    public static ArrayList PopulateCountries(int continentId)
    {
        ArrayList list = new ArrayList();
        String strConnString = ConfigurationManager
            .ConnectionStrings["conString"].ConnectionString;
        String strQuery = "select PK_bdsQuanHuyenID, C_Name from tbl_bdsQuanHuyen where FK_bdsTinhthanhID = @ContinentID and C_Active =1 order by C_Rank desc";
        //String strQuery = "select ID, CountryName from Countries where ContinentID=@ContinentID";
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@ContinentID", continentId);
                cmd.CommandText = strQuery;
                cmd.Connection = con;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    list.Add(new ListItem(
                   sdr["C_Name"].ToString(),
                   sdr["PK_bdsQuanHuyenID"].ToString()
                    ));
                }
                con.Close();
                return list;
            }
        }
    }
    [System.Web.Services.WebMethod]
    public static ArrayList PopulateTenduan(int countryId)
    {
        ArrayList list = new ArrayList();
        String strConnString = ConfigurationManager
            .ConnectionStrings["conString"].ConnectionString;
        String strQuery = "select PK_bdsDuanID, C_Name from tbl_bdsDuan where FK_QuanhuyenID = @CountryID and C_Active =1 order by C_Rank desc";
        //String strQuery = "select ID, CityName from Cities where CountryID=@CountryID";
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CountryID", countryId);
                cmd.CommandText = strQuery;
                cmd.Connection = con;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    list.Add(new ListItem(
                   sdr["C_Name"].ToString(),
                   sdr["PK_bdsDuanID"].ToString()
                    ));
                }
                con.Close();
                return list;
            }
        }
    }
    
    private void PopulateDropDownList(ArrayList list, DropDownList ddl)
    {
        ddl.DataSource = list;
        ddl.DataTextField = "Text";
        ddl.DataValueField = "Value";
        ddl.DataBind();
    }

    







    private void bindTenduan(int FK_TenduanID)
    {
        drdTenduan.Items.Insert(0, new ListItem("Chọn dự án...", "0"));
        int intSelected = 1;
        DataTable dtbdsDuan = clsDatabase.getDataTable("select PK_bdsDuanID, C_Name from tbl_bdsDuan where C_Active =1 order by C_Rank desc");
        for (int intbdsDuan = 0; intbdsDuan < dtbdsDuan.Rows.Count; intbdsDuan++)
        {
            drdTenduan.Items.Add(new ListItem(dtbdsDuan.Rows[intbdsDuan]["C_Name"].ToString(), dtbdsDuan.Rows[intbdsDuan]["PK_bdsDuanID"].ToString()));
            if (Convert.ToInt32(dtbdsDuan.Rows[intbdsDuan]["PK_bdsDuanID"].ToString()) == FK_TenduanID)
                drdTenduan.SelectedIndex = intSelected;
            intSelected++;
        }
    }
    private void bindLoaidiaoc(int FK_LoaidiaocID)
    {
        //Response.Write(FK_LoaidiaocID.ToString());
        DataTable dtbdsLoaidiaoc = clsDatabase.getDataTable("select PK_bdsLoaidiaocID, C_Name from tbl_bdsLoaidiaoc where C_Active =1 order by C_Rank desc");
        int intSelected = 1;
        for (int intbdsLoaidiaoc = 0; intbdsLoaidiaoc < dtbdsLoaidiaoc.Rows.Count; intbdsLoaidiaoc++)
        {
            drdLoaidiaoc.Items.Add(new ListItem(dtbdsLoaidiaoc.Rows[intbdsLoaidiaoc]["C_Name"].ToString(), dtbdsLoaidiaoc.Rows[intbdsLoaidiaoc]["PK_bdsLoaidiaocID"].ToString()));
            if (Convert.ToInt32(dtbdsLoaidiaoc.Rows[intbdsLoaidiaoc]["PK_bdsLoaidiaocID"].ToString()) == FK_LoaidiaocID)
            {
                drdLoaidiaoc.SelectedIndex = intSelected;
            }
            intSelected++;

        }
    }
    /*
    private void bindLoaidiaoc1(int FK_Loaidiaoc1ID)
    {
        DataTable dtbdsLoaidiaoc1 = clsDatabase.getDataTable("select PK_bdsLoaidiaoc1ID, C_Name from tbl_bdsLoaidiaoc1 where C_Active =1 order by C_Rank desc");
        int intSelected = 1;
        for (int intbdsLoaidiaoc1 = 0; intbdsLoaidiaoc1 < dtbdsLoaidiaoc1.Rows.Count; intbdsLoaidiaoc1++)
        {
            drdLoaidiaoc1.Items.Add(new ListItem(dtbdsLoaidiaoc1.Rows[intbdsLoaidiaoc1]["C_Name"].ToString(), dtbdsLoaidiaoc1.Rows[intbdsLoaidiaoc1]["PK_bdsLoaidiaoc1ID"].ToString()));
            if (Convert.ToInt32(dtbdsLoaidiaoc1.Rows[intbdsLoaidiaoc1]["PK_bdsLoaidiaoc1ID"].ToString()) == FK_Loaidiaoc1ID)
            {
                drdLoaidiaoc1.SelectedIndex = intSelected;
            }
            intSelected++;
        }
    }
     * */
    private void bindTinhthanh()
    {
        drdTinhthanh.Items.Insert(0, new ListItem("Chọn nhóm thư mục...", "0"));

        DataTable dtbdsTinhthanh = clsDatabase.getDataTable("select PK_bdsTinhthanhID, C_Name from tbl_bdsTinhthanh where C_Active =1 order by C_Rank desc");
        for (int intbdsTinhthanh = 0; intbdsTinhthanh < dtbdsTinhthanh.Rows.Count; intbdsTinhthanh++)
        {
            drdTinhthanh.Items.Add(new ListItem(dtbdsTinhthanh.Rows[intbdsTinhthanh]["C_Name"].ToString(), dtbdsTinhthanh.Rows[intbdsTinhthanh]["PK_bdsTinhthanhID"].ToString()));
        }

        // handle change events on client
        drdTinhthanh.Attributes.Add("onchange", "getQuanhuyen(this.value);");
        drdQuanhuyen.Attributes.Add("onchange", "getTenduan(this.value);");
        //ddlArticles.Attributes.Add("onchange", "displayResults();");
    }





    protected void cmdDangTin_Click(object sender, EventArgs e)
    {
        string bindTinhthanh = Request.Form[drdTinhthanh.UniqueID];
        string bindQuanhuyen = Request.Form[drdQuanhuyen.UniqueID];
        string bindTenduan = Request.Form[drdTenduan.UniqueID];

        // Repopulate Countries and Cities
        PopulateDropDownList(PopulateCountries(int.Parse(bindTinhthanh)), drdQuanhuyen);

        //Response.Write(bindQuanhuyen);

        if (ImageVerifier1.Text == txtImgVerifyCode.Text)
        {
            int FK_LoaitinraoID = 0;
            int FK_LoaidiaocID = 0;
            int FK_Loaidiaoc1ID = 0;
            int FK_TinhthanhID = 0;
            int FK_QuanhuyenID = 0;
            int FK_PhuongxaID = 0;
            string C_Diachi = "";
            int FK_TenduanID = 0;
            string C_Gia = "";
            int FK_LoaitienteID = 0;
            int FK_LoaidientichID = 0;
            int FK_MoigioiID = 0;
            string C_Dientichsudung = "";
            string C_Dientichdat = "";
            string C_Dientichkhuonvien_dai = "";
            string C_Dientichkhuonvien_rong = "";
            string C_Dientichkhuonvien_rongsau = "";
            string C_Dientichxaydung_dai = "";
            string C_Dientichxaydung_rong = "";
            string C_Dientichxaydung_rongsau = "";
            int FK_TinhtrangphaplyID = 0;
            int FK_SophongkhachID = 0;
            int FK_HuongtaisanID = 0;
            int FK_SophongnguID = 0;
            int FK_DuongtruocnhaID = 0;
            int FK_SophongtamID = 0;
            int FK_SolauID = 0;
            int FK_SophongkhacID = 0;
            int C_Daydutiennghi = 0;
            int C_Chodauxehoi = 0;
            int C_Sanvuon = 0;
            int C_Hoboi = 0;
            int C_Tienkinhdoanh = 0;
            int C_Tiendeo = 0;
            int C_Tienlamvanphong = 0;
            int C_Tienchosanxuat = 0;
            int C_Tienchosinhvienthue = 0;
            string C_Tieude = "";
            string C_Noidung = "";
            string C_Google_X = "";
            string C_Google_Y = "";
            string C_File1 = "";
            string C_File2 = "";
            string C_File3 = "";
            string C_File4 = "";
            string C_File5 = "";
            string C_Nguoilienhe = "";
            string C_Dienthoai = "";
            string C_Didong = "";
            string C_Diachilienhe = "";
            string C_Ghichu = "";

            string C_Duankhac = "";
            int intCheckDuankhac = 0;

            if (chkDuankhac.Checked == true)
            {
                C_Duankhac = clsInput.encodeStr(txtDuankhac.Text);
                intCheckDuankhac = 1;
            }
            else
            {
                C_Duankhac = "";
                intCheckDuankhac = 0;
            }

            int C_Vip = 0;
            int C_Chungthuc = 0;
            int C_Star = 0;
            int C_Active = 0;

            if (chkVip.Checked == true)
                C_Vip = 1;
            if (chkChungthuc.Checked == true)
                C_Chungthuc = 1;
            if (chkActive.Checked == true)
                C_Active = 1;
            C_Star = Convert.ToInt32(drdStar.SelectedValue);

            FK_LoaitinraoID = Convert.ToInt32(rdoLoaitinrao.SelectedValue);
            FK_LoaidiaocID = Convert.ToInt32(drdLoaidiaoc.SelectedValue);
            //FK_Loaidiaoc1ID = Convert.ToInt32(drdLoaidiaoc1.SelectedValue);
            FK_TinhthanhID = Convert.ToInt32(drdTinhthanh.SelectedValue);
            //FK_QuanhuyenID = Convert.ToInt32(drdQuanhuyen.SelectedValue);
            //FK_PhuongxaID = Convert.ToInt32(drdPhuongxa.SelectedValue);

            FK_QuanhuyenID = Convert.ToInt32(bindQuanhuyen);
            

            C_Diachi = clsInput.encodeStr(txtDiachi.Text);
            FK_TenduanID = Convert.ToInt32(bindTenduan);
            C_Gia = clsInput.encodeStr(txtGia.Text);
            C_Gia += "000000";
            FK_LoaitienteID = Convert.ToInt32(drdLoaitiente.SelectedValue);
            FK_LoaidientichID = Convert.ToInt32(drdLoaidientich.SelectedValue);
            FK_MoigioiID = Convert.ToInt32(rdoMoigioi.SelectedValue);
            C_Dientichsudung = clsInput.encodeStr(txtDientichsudung.Text);
            C_Dientichdat = clsInput.encodeStr(txtDientichdat.Text);
            C_Dientichkhuonvien_dai = clsInput.encodeStr(txtDientichkhuonvien_dai.Text);
            C_Dientichkhuonvien_rong = clsInput.encodeStr(txtDientichkhuonvien_rong.Text);
            C_Dientichkhuonvien_rongsau = clsInput.encodeStr(txtDientichkhuonvien_rongsau.Text);
            C_Dientichxaydung_dai = clsInput.encodeStr(txtDientichxaydung_dai.Text);
            C_Dientichxaydung_rong = clsInput.encodeStr(txtDientichxaydung_rong.Text);
            C_Dientichxaydung_rongsau = clsInput.encodeStr(txtDientichxaydung_rongsau.Text);
            FK_TinhtrangphaplyID = Convert.ToInt32(drdTinhtrangphaply.SelectedValue);
            FK_SophongkhachID = Convert.ToInt32(txtSophongkhach.Text);
            FK_HuongtaisanID = Convert.ToInt32(drdHuongtaisan.SelectedValue);
            FK_SophongnguID = Convert.ToInt32(txtSophongngu.Text);
            FK_DuongtruocnhaID = Convert.ToInt32(drdDuongtruocnha.SelectedValue);
            FK_SophongtamID = Convert.ToInt32(txtSophongtam.Text);
            FK_SolauID = Convert.ToInt32(txtSolau.Text);
            FK_SophongkhacID = Convert.ToInt32(txtSophongkhac.Text);
            if (chkDaydutiennghi.Checked)
                C_Daydutiennghi = 1;
            if (chkChodauxehoi.Checked)
                C_Chodauxehoi = 1;
            if (chkSanvuon.Checked)
                C_Sanvuon = 1;
            if (chkHoboi.Checked)
                C_Hoboi = 1;
            if (chkTienkinhdoanh.Checked)
                C_Tienkinhdoanh = 1;
            if (chkTiendeo.Checked)
                C_Tiendeo = 1;
            if (chkTienlamvanphong.Checked)
                C_Tienlamvanphong = 1;
            if (chkTienchosanxuat.Checked)
                C_Tienchosanxuat = 1;
            if (chkTienchosinhvienthue.Checked)
                C_Tienchosinhvienthue = 1;

            C_Tieude = clsInput.encodeStr(txtTieude.Text);
            C_Noidung = clsInput.encodeStr(txtNoidung.Text);
            C_Nguoilienhe = clsInput.encodeStr(txtNguoilienhe.Text);
            C_Dienthoai = clsInput.encodeStr(txtDienthoai.Text);
            C_Didong = clsInput.encodeStr(txtDidong.Text);
            C_Diachilienhe = clsInput.encodeStr(txtDiachilienhe.Text);
            C_Ghichu = clsInput.encodeStr(txtGhichu.Text);

            //Reset display err
            block_error.Text = "";
           


            try
            {
                int intID = clsInput.getNumericInput("id", 0);
                string strSql = "update tbl_Tindang set FK_LoaitinraoID = " + FK_LoaitinraoID + ", C_Vip=" + C_Vip + ", C_Chungthuc=" + C_Chungthuc + ", C_Star=" + C_Star + ", C_Active=" + C_Active + ", FK_LoaidiaocID=" + FK_LoaidiaocID + ", FK_Loaidiaoc1ID=" + FK_Loaidiaoc1ID + ", FK_TinhthanhID = " + FK_TinhthanhID + ", FK_QuanhuyenID = " + FK_QuanhuyenID + ", C_CheckDuankhac = " + intCheckDuankhac + ", C_Duankhac = N'" + C_Duankhac  + "', C_Diachi = N'" + C_Diachi + "', FK_TenduanID=" + FK_TenduanID + ", C_Gia = " + C_Gia + ", FK_LoaitienteID = " + FK_LoaitienteID + ", FK_LoaidientichID = " + FK_LoaidientichID + ", FK_MoigioiID = " + FK_MoigioiID + ", C_Dientichsudung = '" + C_Dientichsudung + "', C_Dientichdat = '" + C_Dientichdat + "', C_Dientichkhuonvien_dai = '" + C_Dientichkhuonvien_dai + "', C_Dientichkhuonvien_rong = '" + C_Dientichkhuonvien_rong + "', C_Dientichkhuonvien_rongsau = '" + C_Dientichkhuonvien_rongsau + "', C_Dientichxaydung_dai = '" + C_Dientichxaydung_dai + "', C_Dientichxaydung_rong = '" + C_Dientichxaydung_rong + "', C_Dientichxaydung_rongsau = '" + C_Dientichxaydung_rongsau + "', FK_TinhtrangphaplyID = '" + FK_TinhtrangphaplyID + "', FK_SophongkhachID = '" + FK_SophongkhachID + "', FK_HuongtaisanID = " + FK_HuongtaisanID + ", FK_SophongnguID = " + FK_SophongnguID + ", FK_DuongtruocnhaID = " + FK_DuongtruocnhaID + ", FK_SophongtamID = " + FK_SophongtamID + ", FK_SolauID = " + FK_SolauID + ", FK_SophongkhacID = " + FK_SophongkhacID + ", C_Daydutiennghi = " + C_Daydutiennghi + ", C_Chodauxehoi = " + C_Chodauxehoi + ", C_Sanvuon = " + C_Sanvuon + ", C_Hoboi = " + C_Hoboi + ", C_Tienkinhdoanh = " + C_Tienkinhdoanh + ", C_Tiendeo = " + C_Tiendeo + ", C_Tienlamvanphong = " + C_Tienlamvanphong + ", C_Tienchosanxuat = " + C_Tienchosanxuat + ", C_Tienchosinhvienthue = " + C_Tienchosinhvienthue + ", C_Tieude = N'" + C_Tieude + "', C_Noidung = N'" + C_Noidung + "', C_Nguoilienhe = N'" + C_Nguoilienhe + "', C_Dienthoai = N'" + C_Dienthoai + "', C_Didong = N'" + C_Didong + "', C_Diachilienhe = N'" + C_Diachilienhe + "', C_Ghichu = N'" + C_Ghichu + "' where PK_TindangID = " + intID;
                clsDatabase.ExecuteQuery(strSql);
                //int intInsertRecord = clsDatabase.getInsertID("tbl_Tindang", "PK_TindangID");
                //Xac lap ma loai tin
                //string strMatin = this.Session["Front_UserID"].ToString() + FK_LoaitinraoID + intInsertRecord;
                //clsDatabase.ExecuteQuery("update tbl_Tindang set C_Rank = " + intInsertRecord + ", C_Code = '" + strMatin + "' where PK_TindangID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=tindang&mod=tindang&type="+clsInput.getStringInput("type",0));
            }
            catch
            {
                clsErr.setFrontErr("Lỗi", "Bạn hãy kiểm tra lại thông tin");
                block_error.Text = clsErr.displayFrontErr();
            }

            //Response.Write(strSql);


        }
        else
        {
            block_error.Text = "";
            clsErr.setErr("Mã xác thực", "Mã xác thực bạn nhập vào chưa chính xác");
            if (clsErr.checkErr())
            {
                block_error.Text = clsErr.displayFrontErr();
            }
        }
    }
}
