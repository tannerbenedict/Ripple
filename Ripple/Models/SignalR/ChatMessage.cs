using MessagePack;

namespace FamilyGameNight.Models.SignalR;

[MessagePackObject]
public class ChatMessage
{
    [Key("author")]
    public string Author { get; set; }
    [Key("message")]
    public string Message { get; set; }

    public ChatMessage(string author, string message)
    {
        Author = author;
        Message = message;
    }
}