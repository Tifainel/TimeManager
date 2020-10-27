import config from "../../config.json";

export async function getTeamsbyManagerId(userId) {
  try {
    const teams = await fetch(`${config.api_url}/teams/${userId}`, {
      method: "GET"
    });
    return await teams.json();
  } catch (e) {
    return { error: e };
  }
}

export async function getOneTeam(userId, teamId) {
  try {
    const team = await fetch(`${config.api_url}/teams/${userId}/${teamId}`, {
      method: "GET"
    });
    return await team.json();
  } catch (e) {
    return { error: e };
  }
}

export async function getTeamsByUserId(userId) {
  try {
    const teams = await fetch(`${config.api_url}/member_teams/${userId}`, {
      method: "GET"
    });
    return await teams.json();
  } catch (e) {
    return { error: e };
  }
}

export async function createTeam(data) {
  try {
    const team = await fetch(`${config.api_url}/teams/`, {
      method: "POST",
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      },
      body: JSON.stringify({
        user_id: data.userId,
        name: data.name,
        members: []
      })
    });
    return { res: "success" };
  } catch (e) {
    return { error: e };
  }
}

export async function modifyTeam(teamId, data) {
  try {
    const team = await fetch(`${config.api_url}/teams/${teamId}`, {
      method: "PUT",
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      },
      body: JSON.stringify({
        team: { user_id: data.userId, name: data.name, members: data.members }
      })
    });
    return { res: "success" };
  } catch (e) {
    return { error: e };
  }
}

export async function deleteTeam(teamId) {
  try {
    const user = await fetch(`${config.api_url}/teams/${teamId}`, {
      method: "DELETE"
    });
  } catch (e) {
    return { error: e };
  }
}
