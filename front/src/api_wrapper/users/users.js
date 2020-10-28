import config from '../../config.json';

export async function getUserById(userId) {
  try {
    const user = await fetch(`${config.api_url}/users/${userId}`, {
      method: 'GET',
    });
    return (await user.json()).data;
  } catch (e) {
    return { error: e };
  }
}

export async function updateUserById(userId, userData) {
  try {
    const user = await fetch(`${config.api_url}/users/${userId}`, {
      method: 'PUT',
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({
        user: { username: userData.username, email: userData.email },
      }),
    });
    return { res: 'success' };
  } catch (e) {
    return { error: e };
  }
}

export async function deleteUserById(userId) {
  try {
    const user = await fetch(`${config.api_url}/users/${userId}`, {
      method: 'DELETE',
    });
  } catch (e) {
    return { error: e };
  }
}

export async function createUser(userData) {
  try {
    const user = await fetch(`${config.api_url}/users`, {
      method: 'POST',
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({
        user: { username: userData.username, email: userData.email },
      }),
    });
    return { res: 'success' };
  } catch (e) {
    return { error: e };
  }
}

export async function createUserWithRole(userData) {
  try {
    const user = await fetch(`${config.api_url}/users`, {
      method: 'POST',
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({
        user: {
          username: userData.username,
          email: userData.email,
          role: userData.role,
        },
      }),
    });
    return { res: 'success' };
  } catch (e) {
    return { error: e };
  }
}
