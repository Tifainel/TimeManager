import { getDeviceType } from './getDeviceType';

export function getConnexionType() {
  if (getDeviceType() === 'mobile') return navigator.connection.type;
  return 'desktop';
}
