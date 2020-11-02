import config from '../../config.json';
import { setMobileLocalStorage } from '../../helpers/localStorage';
import { getConnexionType } from '../../helpers/getConnexionType';

export async function getUserById(userId) {
  try {
    const user = await fetch(`${config.api_url}/users/${userId}`, {
      method: 'GET',
    });
    const userRes = (await user.json()).data;
    setMobileLocalStorage('user', userRes);
    return userRes;
  } catch (e) {
    if (getConnexionType === 'none') {
      return JSON.parse(window.localStorage.getItem('user'));
    }
    return { error: e };
  }
}

export async function getUserByEmailAndUsername(email, username) {
  try {
    const user = await fetch(
      `${config.api_url}/users?email=${email}&username=${username}`,
      {
        method: 'GET',
      },
    );
    return await user.json();
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
        user: {
          username: userData.username,
          email: userData.email,
          password: userData.password,
          role: userData.role,
        },
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
        user: {
          username: userData.username,
          email: userData.email,
          password: userData.password,
        },
      }),
    });
    return await user.json();
  } catch (e) {
    return { error: e };
  }
}

export async function signin(userData) {
  try {
    const token = await fetch(
      `${config.api_url}/users/signin?username=${userData.username}&password=${userData.password}`,
      {
        method: 'GET',
      },
    );
    return await token.json();
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
