import { getDeviceType } from './getDeviceType';

export function setMobileLocalStorage(key, value) {
  if (getDeviceType() === 'mobile')
    window.localStorage.setItem(key, JSON.stringify(value));
}
