import config from '../../config.json';

export async function getRoles() {
  try {
    const roles = await fetch(`${config.api_url}/roles`, {
      method: 'GET',
    });
    return (await roles.json());
  } catch (e) {
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

