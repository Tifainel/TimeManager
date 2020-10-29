import DashboardLayout from '../layout/DashboardLayout.vue';
// GeneralViews
import NotFound from '../pages/NotFoundPage.vue';

// Admin pages
import User from 'src/pages/User.vue';
import Dashboard from 'src/pages/Dashboard.vue';
import WorkingTimes from 'src/pages/WorkingTimes.vue';
import TeamsPage from 'src/pages/TeamsPage.vue';
import SignIn from 'src/pages/SignIn.vue';
import SignUp from 'src/pages/SignUp.vue';
import AdministrationPage from 'src/pages/AdministrationPage';
import Faq from 'src/pages/Faq.vue';

import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';

function guard(to, from, next) {
  if (Cookies.get('token')) {
    next();
  } else {
    next('/signin');
  }
}

function redirectToDashboard(to, from, next) {
  if (!Cookies.get('token')) {
    next();
  } else {
    next('/dashboard');
  }
}

function managerGuard(to, from, next) {
  const token = Cookies.get('token');
  if (token) {
    if (jwt_decode(token).role === 2 || jwt_decode(token).role === 3) next();
    else {
      next('/dashboard');
    }
  }
}

function adminGuard(to, from, next) {
  const token = Cookies.get('token');
  if (token) {
    if (jwt_decode(token).role === 3) next();
    else {
      next('/dashboard');
    }
  }
}

const routes = [
  {
    path: '/signin',
    name: 'SignIn',
    beforeEnter: redirectToDashboard,
    component: SignIn,
  },
  {
    path: '/signup',
    name: 'SignUp',
    beforeEnter: redirectToDashboard,
    component: SignUp,
  },
  {
    path: '/',
    component: DashboardLayout,
    beforeEnter: guard,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: Dashboard,
      },
      {
        path: 'user',
        name: 'User',
        component: User,
      },
      {
        path: 'workingtimes',
        name: 'WorkingTimes',
        component: WorkingTimes,
      },
      {
        path: 'teams',
        name: 'Teams',
        beforeEnter: managerGuard,
        component: TeamsPage,
      },
      {
        path: 'administration',
        name: 'Administration',
        beforeEnter: adminGuard,
        component: AdministrationPage,
      },
    ],
  },
  { path: '*', component: NotFound },
  {
    path: '/help',
    component: Faq,
  },
];

/**
 * Asynchronously load view (Webpack Lazy loading compatible)
 * The specified component must be inside the Views folder
 * @param  {string} name  the filename (basename) of the view to load.
function view(name) {
   var res= require('../components/Dashboard/Views/' + name + '.vue');
   return res;
};**/

export default routes;
