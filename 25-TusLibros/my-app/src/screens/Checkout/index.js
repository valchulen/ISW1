import React, { useState } from 'react'
import Card from '@material-ui/core/Card';
import TextField from '@material-ui/core/TextField';
import IconButton from '@material-ui/core/IconButton';
import RemoveIcon from '@material-ui/icons/Remove';
import Button from '@material-ui/core/Button';

import { catalog } from '../constants';

import styles from './styles.module.css';

const Component = ({ currentCart, onSubmit, removeItem }) => (
    <div className={styles.container} >
        <Card>
            {currentCart && currentCart.books && currentCart.books.map(book => <Item onRemoveItem={removeItem} currentBook={book} />)}
            {(!currentCart || !currentCart.books || currentCart.books.length === 0) && <h1> NO HAY ELEMENTOS EN SU CARRITO </h1>}
            {currentCart && currentCart.books && <CreditCard onSubmit={onSubmit} />}
        </Card>
    </div>
);

const CreditCard = ({ onSubmit }) => {
    const [ccn, setCcn] = useState('');
    const [cced, setCced] = useState('');
    const [cco, setCco] = useState('');

    const handleChangeCcn = e => {
        setCcn(e.target.value);
    };

    const handleChangeCced = e => {
        setCced(e.target.value);
    };

    const handleChangeCco = e => {
        setCco(e.target.value);
    };

    const handleSubmit = e => {
        e.preventDefault();
        onSubmit(ccn, cced, cco);
    };

    return (
        <div className={styles.card}>
            <h2 className={styles.title}> Informacion de pago </h2>
            <form className={styles.formContainer} onSubmit={handleSubmit}>
                <TextField className={styles.textField} required placeholder="Numero" onChange={handleChangeCcn} />
                <TextField className={styles.textField} required placeholder="Fecha de Expiracion" onChange={handleChangeCced} />
                <TextField className={styles.textField} required placeholder="Nombre" onChange={handleChangeCco} />
                <Button type="submit" onClick={handleSubmit}> Cobrar </Button>
            </form>
        </div>
    );
}

const Item = ({ onRemoveItem, currentBook }) => {
    const [value, setValue] = useState(0);

    const handleChange = e => {
        setValue(e.target.value);
    };

    const handleSubmit = e => {
        e.preventDefault();
        onRemoveItem(currentBook.isbn, value);
        setValue(e.target.value);
    }

    const bookInfo = currentBook && catalog[currentBook.isbn]

    return (
        currentBook ?
            <div className={styles.item}>
                <div>
                    <h4> {`Titulo: ${bookInfo.title}`} </h4>
                    <h5> {`Autor: ${bookInfo.author}`} </h5>
                    <h5> {`Cantidad: ${currentBook.quantity}`} </h5>
                </div>
                <form className={styles.form}>
                    <TextField
                        id="quantity"
                        type="number"
                        className={styles.quantity}
                        onChange={handleChange}
                        inputProps={{ min: "0", max: currentBook.quantity }}
                    />
                    <IconButton type="submit" onClick={handleSubmit} disabled={value == 0}>
                        <RemoveIcon />
                    </IconButton>
                </form>
            </div> : <div></div>
    );
}


export default Component;