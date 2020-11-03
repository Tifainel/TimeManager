import config from '../../config.json';
import { setMobileLocalStorage } from '../../helpers/localStorage';
import { getConnexionType } from '../../helpers/getConnexionType';
import Cookies from 'js-cookie';

const userToken = Cookies.get('token');

export async function getRoles() {
  try {
    const roles = await fetch(`${config.api_url}/roles`, {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${userToken}`,
      },
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
