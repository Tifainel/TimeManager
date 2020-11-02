import config from '../../config.json';
import { setMobileLocalStorage } from '../../helpers/localStorage';
import { getConnexionType } from '../../helpers/getConnexionType';

export async function getLastClockbyUserId(userId) {
  try {
    const clock = await fetch(`${config.api_url}/clocks/${userId}/last`, {
      method: 'GET',
    });
    const res = await clock.json();
    setMobileLocalStorage('clock', res);
    return res;
  } catch (e) {
    if (getConnexionType === 'none') {
      return JSON.parse(window.localStorage.getItem('clock'));
    }
    return { error: e };
  }
}

export async function createClock(userId, data) {
  try {
    const user = await fetch(`${config.api_url}/clocks/${userId}`, {
      method: 'POST',
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({
        clock: {
          time: data.time,
          status: data.status,
        },
      }),
    });
    return { res: 'success' };
  } catch (e) {
    if (getConnexionType === 'none') {
      let clock = JSON.parse(window.localStorage.getItem('clock'));
      clock.time = new Date().toISOString();
      clock.status = !clock.status;
      setMobileLocalStorage('clock', clock);
    }
    return { error: e };
  }
}
