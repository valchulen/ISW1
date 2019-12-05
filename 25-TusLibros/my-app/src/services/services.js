const apiFetch = (parameters, method) => {
    const port = 8080;

    return fetch(`http://localhost:${port}/${parameters}`, {
        method: method,
        dataType: 'JSON',
        headers: {
            'Access-Control-Request-Headers': '*'
        }
    });
} 


export const getValidCarts = (user, pass) => {
    apiFetch(`/listActiveCarts?clientId=${user}&password=${pass}`, 'GET')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return json.validCarts;
    })
    .catch(error => {
        if(!alert("Hubo un error validando sus datos. \nIntente mas tarde")){window.location.reload()};
    })
}

export const createNewCart = () => {
    apiFetch(`/createNewCart`, 'GET')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return {id: json.cartId, books: []};
    })
    .catch(error => {
        if(!alert("Hubo un error recuperando sus datos. \nIntente mas tarde")){window.location.reload()};
    })
}

export const getCartItems = cartId => {
    apiFetch(`/listCart?cartId=${cartId}`, 'GET')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return {id: cartId, books: json.books};
    })
    .catch(error => {
        if(!alert("Hubo un error validando sus datos. \nIntente mas tarde")){window.location.reload()};
    })
}

export const addToCart = (cartId, isbn, amount) => {
    apiFetch(`/addToCart?cartId=${cartId}&bookIsbn=${isbn}&bookQuantity=${amount}`, 'POST')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return true;
    })
    .catch(error => {
        if(!alert("Hubo un error agregando la informacion a su carrito. \nIntente mas tarde")){window.location.reload()};
    })
}

export const removeFromCart = (cartId, isbn, amount) => {
    apiFetch(`/deleteFromCart?cartId=${cartId}&bookIsbn=${isbn}&bookQuantity=${amount}`, 'POST')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return true;
    })
    .catch(error => {
        if(!alert("Hubo un error eliminando la informacion a su carrito. \nIntente mas tarde")){window.location.reload()};
    })
}

export const checkoutCart = (cartId, ccn, cced, cco) => {
    apiFetch(`/checkOutCart?cartId=${cartId}&ccn=${ccn}&cced=${cced}&cco=${cco}`, 'POST')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return true;
    })
    .catch(error => {
        if(!alert("Hubo un error efectuando la compra. \nIntente mas tarde")){window.location.reload()};
    })
}

export const getUserHistory = (user, pass) => {
    apiFetch(`/listPurchases?clientId=${user}&password=${pass}`, 'GET')
    .then(response => {
        return response.json();
    })
    .then(json => {
        return json;
    })
    .catch(error => {
        if(!alert("Hubo un recuperando su historial. \nIntente mas tarde")){window.location.reload()};
    })
}