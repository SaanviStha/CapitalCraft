using System;
using System.IO;
using System.Web;
using System.Web.Hosting;
using System.Web.UI.WebControls;

public static class Pictures
{
    public const string Placeholder = "/images/course-placeholder.svg";

    public const int MaxMegabytes = 5;

    // get course picture or placeholder
    public static string Course(object path)
    {
        string image = (path ?? "").ToString();

        if (image == "" || !File.Exists(HostingEnvironment.MapPath("~/" + image)))
        {
            return Placeholder;
        }
        return "/" + image;
    }

    // check the uploaded picture
    public static string Check(FileUpload upload)
    {
        string extension = Path.GetExtension(upload.FileName).ToLower();
        if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".webp")
        {
            return "Picture must be a .jpg, .png or .webp file.";
        }

        if (upload.PostedFile.ContentLength > MaxMegabytes * 1024 * 1024)
        {
            return "The picture is too big. The largest allowed is " + MaxMegabytes + " MB.";
        }

        return "";
    }

    // save picture to images folder
    public static string Save(FileUpload upload, HttpServerUtility server)
    {
        string folder = server.MapPath("~/images/");
        string fileName = Path.GetFileName(upload.FileName);

        // don't overwrite a picture with the same name
        if (File.Exists(folder + fileName))
        {
            fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + fileName;
        }

        upload.SaveAs(folder + fileName);
        return "images/" + fileName;
    }
}
