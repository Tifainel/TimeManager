import DashboardLayout from '../layout/DashboardLayout.vue';
// GeneralViews
import NotFound from '../pages/NotFoundPage.vue';

// Admin pages
import Overview from 'src/pages/Overview.vue';
import User from 'src/pages/User.vue';
import Dashboard from 'src/pages/Dashboard.vue';
import WorkingTimes from 'src/pages/WorkingTimes.vue'
import TablesList from 'src/pages/TablesList.vue';
const routes = [
  {
    path: '/',
    component: DashboardLayout,
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
    ],
  },
  { path: '*', component: NotFound },
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
