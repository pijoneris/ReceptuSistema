import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { store } from './app/store';
import { Provider } from 'react-redux';
import * as serviceWorker from './serviceWorker';
import AuthenticatedRoute from './AuthenticatedRoute';
import LoginPage from './pages/login/LoginPage';
import {
  BrowserRouter as Router,
  Redirect,
  Route,
  Switch,
} from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'react-toastify/dist/ReactToastify.css';
import { toast } from 'react-toastify';
import RegisterPage from './pages/register/RegisterPage';

toast.configure({
  position: 'bottom-right',
});

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <Router>
        <Switch>
          <Route path="/login">
            <LoginPage />
          </Route>
          <Route path='/register'>
            <RegisterPage />
          </Route>
          <AuthenticatedRoute path="/app">
            <App />
          </AuthenticatedRoute>
          <Redirect to={'/app'} />
        </Switch>
      </Router>
    </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
