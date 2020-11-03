import config from '../../config.json';
import { setMobileLocalStorage } from '../../helpers/localStorage';
import { getConnexionType } from '../../helpers/getConnexionType';

export async function getAllWorkingTimesByUserId(userId, start, end) {
  try {
    const workingtimes = await fetch(
      `${config.api_url}/workingtimes/${userId}?start=${start}&end=${end} `,
      {
        method: 'GET',
      },
    );
    const res = await workingtimes.json();
    setMobileLocalStorage('workingTimes', res);
    return res;
  } catch (e) {
    if (getConnexionType() === 'none') {
      return JSON.parse(window.localStorage.getItem('workingTimes'));
    }
    return { error: e };
  }
}

export async function getOneWorkingTimeByUserId(userId, workingtimeID) {
  try {
    const workingtime = await fetch(
      `${config.api_url}/workingtimes/${userId}/${workingtimeID}`,
      {
        method: 'GET',
      },
    );
    return await workingtime.json();
  } catch (e) {
    return { error: e };
  }
}

export async function createWorkingtime(userId, start, end) {
  try {
    const workingtime = await fetch(
      `${config.api_url}/workingtimes/${userId}`,
      {
        method: 'POST',
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
          workingtime: {
            start: start,
            end: end,
          },
        }),
      },
    );
    return { res: 'success' };
  } catch (e) {
    return { error: e };
  }
}

export async function updateWorkingtimeById(workingtimeID, data) {
  try {
    const workingtime = await fetch(
      `${config.api_url}/workingtimes/${workingtimeID}`,
      {
        method: 'PUT',
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
          workingtime: { start: data.start, end: data.end },
        }),
      },
    );
    return { res: 'success' };
  } catch (e) {
    return { error: e };
  }
}

export async function deleteWorkingtimeById(workingtimeID) {
  try {
    const user = await fetch(
      `${config.api_url}/workingtimes/${workingtimeID}`,
      {
        method: 'DELETE',
      },
    );
    return { res: 'success' };
  } catch (e) {
    return { error: e };
  }
}
