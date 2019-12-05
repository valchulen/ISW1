import React, {useState} from 'react'
import Card from '@material-ui/core/Card';
import Button from '@material-ui/core/Button';
import Radio from '@material-ui/core/Radio';
import RadioGroup from '@material-ui/core/RadioGroup';
import FormControlLabel from '@material-ui/core/FormControlLabel';

import styles from './styles.module.css'

const Carts = ({carts, onSubmit}) => {
    const [value, setValue] = useState('');

    const handleChange = e => {
        setValue(e.target.value);
    };

    const handleSubmit = e => {
        e.preventDefault();
        onSubmit(value);
    };

    const showCart = cart => (
        <FormControlLabel value={cart.toString()} control={<Radio />} label={`Carrito ${cart}`} key={cart}/>
    );

    return (
        <div className={styles.container}> 
            <Card>
                <h2 className={styles.title}> Seleccione un carrito </h2>
                <form className={styles.formContainer} onSubmit={handleSubmit}>
                    <RadioGroup name="carts" value={value} onChange={handleChange}>
                        {carts.map(cart => showCart(cart))}
                        <FormControlLabel value="newCart" control={<Radio />} label="Nuevo carrito" key="newCart" />
                    </RadioGroup>
                    <Button type="submit" onClick={handleSubmit}> Seleccionar </Button>
                </form>
            </Card>
        </div>
    );
};
export default Carts;