import config from '../../config.json';
import { setMobileLocalStorage } from '../../helpers/localStorage';
import { getConnexionType } from '../../helpers/getConnexionType';

export async function getRoles() {
  try {
    const roles = await fetch(`${config.api_url}/roles`, {
      method: 'GET',
    });
    const res = await roles.json();
    setMobileLocalStorage('roles', res);
    return res;
  } catch (e) {
    if (getConnexionType() === 'none') {
      return JSON.parse(window.localStorage.getItem('roles'));
    }
    return { error: e };
  }
}

// export async function createClock(userId, data) {
//   try {
//     const user = await fetch(`${config.api_url}/clocks/${userId}`, {
//       method: 'POST',
//       headers: {
//         'Content-type': 'application/json; charset=UTF-8',
//       },
//       body: JSON.stringify({
//         time: data.time, status: data.status
//       }),
//     });
//     return { res: 'success' };
//   } catch (e) {
//     return { error: e };
//   }
// }
