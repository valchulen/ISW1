import React, { useState } from 'react'
import Card from '@material-ui/core/Card';
import TextField from '@material-ui/core/TextField';
import IconButton from '@material-ui/core/IconButton';
import AddIcon from '@material-ui/icons/Add';
import Button from '@material-ui/core/Button';


import styles from './styles.module.css'
import { catalog } from '../constants';

const Catalog = ({ onSubmit, addItem }) => {

    return (
        <div className={styles.container}>
            <Card>
                {catalog.map(book => <Item onAddItem={addItem} currentBook={book} />)}
                <div className={styles.button}>
                    <Button onClick={onSubmit}> Comprar </Button>
                </div>
            </Card>
        </div>
    );
};

const Item = ({ onAddItem, currentBook }) => {
    const [value, setValue] = useState(0);

    const handleChange = e => {
        setValue(e.target.value);
    };

    const handleSubmit = e => {
        e.preventDefault();
        onAddItem(currentBook.isbn, value);
    }

    return (
        <div className={styles.item}>
            <div>
                <h4> {`Titulo: ${currentBook.title}`} </h4>
                <h5> {`Autor: ${currentBook.author}`} </h5>
            </div>
            <form className={styles.form}>
                <TextField
                    id="quantity"
                    type="number"
                    className={styles.quantity}
                    onChange={handleChange}
                    inputProps={{ min:"0" }}
                />
                <IconButton type="submit" onClick={handleSubmit} disabled={value == 0}>
                    <AddIcon />
                </IconButton>
            </form>
        </div>
    );
}

export default Catalog;