using System;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

public static class Readings
{
    public const int MaxMegabytes = 10;

    // check the uploaded pdf
    public static string Check(FileUpload upload)
    {
        if (Path.GetExtension(upload.FileName).ToLower() != ".pdf")
        {
            return "Reading must be a PDF file (.pdf).";
        }

        if (upload.PostedFile.ContentLength > MaxMegabytes * 1024 * 1024)
        {
            return "The PDF is too big. The largest allowed is " + MaxMegabytes + " MB.";
        }

        return "";
    }

    // save pdf in readings folder
    public static string Save(FileUpload upload, HttpServerUtility server)
    {
        string folder = server.MapPath("~/readings/");
        string fileName = Path.GetFileName(upload.FileName);

        if (File.Exists(folder + fileName))
        {
            fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + fileName;
        }

        upload.SaveAs(folder + fileName);
        return "readings/" + fileName;
    }
}
