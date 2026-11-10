using System;

public static class Videos
{
    // get the video id from a youtube link
    public static string YouTubeId(string link)
    {
        link = (link ?? "").Trim();
        string id = "";

        if (link.Contains("youtube.com/watch") && link.Contains("v="))
        {
            id = link.Substring(link.IndexOf("v=") + 2);
        }
        else if (link.Contains("youtu.be/"))
        {
            id = link.Substring(link.IndexOf("youtu.be/") + 9);
        }

        if (id.Length < 11)
        {
            return "";
        }
        return id.Substring(0, 11);
    }

    // url for the video iframe
    public static string EmbedUrl(string link)
    {
        string id = YouTubeId(link);
        if (id == "")
        {
            return "";
        }
        return "https://www.youtube.com/embed/" + id;
    }
}
