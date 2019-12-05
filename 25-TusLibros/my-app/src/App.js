import React, { useState } from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Redirect
} from "react-router-dom";
import IconButton from '@material-ui/core/IconButton';
import HomeIcon from '@material-ui/icons/Home';
import HistoryIcon from '@material-ui/icons/History';

import LogIn from './screens/LogIn';
import Carts from './screens/Carts';
import Catalog from './screens/Catalog';
import Checkout from './screens/Checkout';
import History from './screens/History';
import styles from './styles.module.css';

import { getValidCarts, getCartItems, createNewCart, addToCart, removeFromCart, checkoutCart, getUserHistory } from './services/services';

function App() {
  // lazy store
  const [currentUser, setUser] = useState('');
  const [currentPass, setPass] = useState('');
  const [carts, setCarts] = useState([]);
  const [currentCart, setCurrentCart] = useState({});
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [isCartLoaded, setIsCartLoaded] = useState(false);
  const [isProcessingCheckout, setIsProcessingCheckout] = useState(false);
  const [isInHistory, setIsInHistory] = useState(false);
  const [history, setHistory] = useState({});

  const handleLogIn = (user, pass) => {
    setUser(user);
    setPass(pass);
    const validCarts = getValidCarts(user, pass, cleanAll);
    setCarts(validCarts);
    setIsLoggedIn(true);
  };

  const handleSelectCart = cartId => {
    let cartInfo;
    if (cartId === "newCart") {
      cartInfo = createNewCart();
    } else {
      cartInfo = getCartItems(cartId);
    }
    setCurrentCart(cartInfo);
    setIsCartLoaded(true);
  };

  const handleAddToCart = (isbn, amount) => {
    let found = false;
    let newCart = currentCart.books.map(item => {
      if (item.isbn == isbn) {
        found = true;
        return { isbn: isbn, quantity: item.quantity + amount }
      }
      return item;
    })
    if (!found) newCart.push({ isbn: isbn, quantity: amount });
    const id = currentCart.id;
    setCurrentCart({ id: id, books: newCart })
    addToCart(id, isbn, amount);
  };

  const handleRemoveFromCart = (isbn, amount) => {
    let newCart = currentCart.books.map(item => {
      if (item.isbn == isbn) {
        if (item.quantity - amount > 0) {
          return { isbn: isbn, quantity: item.quantity - amount };
        }
        return { isbn: -1, quantity: 0 };
      } else {
        return item;
      }
    })

    newCart = newCart.filter(item => item.quantity > 0);
    const id = currentCart.id;
    setCurrentCart({ id: id, books: newCart });
    removeFromCart(id, isbn, amount);
  };

  const handleCheckoutInit = () => {
    setIsProcessingCheckout(true);
  };

  const cleanAll = () => {
    setIsProcessingCheckout(false);
    setIsLoggedIn(false);
    setIsCartLoaded(false);
    setIsInHistory(false);
    setUser('');
    setPass('');
    setCarts([]);
    setCurrentCart({});
    setHistory({});
  };

  const handleCheckout = (ccn, cced, cco) => {
    cleanAll();
    checkoutCart(currentCart.id, ccn, cced, cco);
  };

  const goToHistory = () => {
    const userHistory = getUserHistory(currentUser, currentPass);
    cleanAll();
    setHistory(userHistory);
    setIsInHistory(true);
  }

  const goToDashboard = () => {
    cleanAll();
  }
  console.log(isInHistory)
  return (
    <div>
      <div className={styles.topbar}>
        <div>
          <IconButton onClick={goToDashboard} disabled={!isLoggedIn}>
            <HomeIcon />
          </IconButton>
        </div>
        <div>
          <IconButton onClick={goToHistory} disabled={!isLoggedIn}>
            <HistoryIcon />
          </IconButton>
        </div>
      </div>
      <Router>
        <Switch>
          <Route path="/carritos">
            {isCartLoaded ? <Redirect to="/catalogo" /> : isLoggedIn ? <Carts carts={carts} onSubmit={handleSelectCart} /> : isInHistory ? <Redirect to="/historial" /> : <Redirect to="/" />}
          </Route>
          <Route path="/catalogo">
            {isProcessingCheckout ? <Redirect to="/checkout" /> : isLoggedIn ? <Catalog onSubmit={handleCheckoutInit} addItem={handleAddToCart} /> : isInHistory ? <Redirect to="/historial" /> : <Redirect to="/" />}
          </Route>
          <Route path="/checkout">
            {isLoggedIn ? <Checkout currentCart={currentCart} onSubmit={handleCheckout} removeItem={handleRemoveFromCart} /> : isInHistory ? <Redirect to="/historial" /> : <Redirect to="/" />}
          </Route>
          <Route path="/historial">
            {isInHistory ? <History history={history} /> : <Redirect to="/" />}
          </Route>
          <Route exact path="/">
            {isLoggedIn ? <Redirect to="/carritos" /> : isInHistory ? <Redirect to="/historial" /> : <LogIn onSubmit={handleLogIn} />}
          </Route>
        </Switch>
      </Router>
    </div>
  );
}

export default App;
