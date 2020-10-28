import DashboardLayout from '../layout/DashboardLayout.vue';
// GeneralViews
import NotFound from '../pages/NotFoundPage.vue';

// Admin pages
import Overview from 'src/pages/Overview.vue';
import User from 'src/pages/User.vue';
import Dashboard from 'src/pages/Dashboard.vue';
import WorkingTimes from 'src/pages/WorkingTimes.vue';
import TeamsPage from 'src/pages/TeamsPage.vue';
import SignIn from 'src/pages/SignIn.vue';
import SignUp from 'src/pages/SignUp.vue';
import TablesList from 'src/pages/TablesList.vue';
import Faq from 'src/pages/Faq.vue';

const routes = [
  {
    path: '/sign-in',
    name: 'SignIn',
    component: SignIn,
  },
  {
    path: '/sign-up',
    name: 'SignUp',
    component: SignUp,
  },
  {
    path: '/',
    component: DashboardLayout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: Dashboard,
      },
      {
        path: 'overview',
        name: 'Overview',
        component: Overview,
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
        component: TeamsPage,
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
