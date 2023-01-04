namespace GameApi.Models;

public class GameItem
{
    public long Id { get; set; }
    public string? HomeTeamName { get; set; }
    public string? GuestTeamName { get; set; }
    public int ResultHomeTeam { get; set; }
    public int ResultGuestTeam { get; set; }
    public bool IsComplete { get; set; }
}