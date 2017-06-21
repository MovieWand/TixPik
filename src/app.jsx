import React from 'react';
import { render } from 'react-dom';
import { createHashHistory, useBaseName } from 'history';
import { Router } from 'react-router';
import "./common/styles/app.less";
import NProgress from 'nProgress';

NProgress.configure({ showSpinner: false });

const history = useBaseName(createHashHistory) ({
    queryKey: false
})

const rootRoute = {
    path: '/',
    components: './components/layouts/Base',
    indexRoute: { components: require('./components/layouts/Dashboard')},
    childRoutes: [
        {
            component: require('./components/layouts/Dashboard'),
            indexRoute: {component: require('./components/pages/dashboard/Overview')},
            childRoutes: [
                require('./components/pages/dashboard/Overview'),
                require('./components/pages/dashboard/Reports'),
            ]
        },
        {
            path: './login',
            component: require('./components/pages/Login'),
            childRoutes: [
            ]
        }
    ]
}

render(
    <Router history={history} routes={rootRoute} />,
    document.getElementById('app')
)