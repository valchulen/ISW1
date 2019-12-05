import React from 'react'
import Card from '@material-ui/core/Card';

import { catalog } from '../constants';

import styles from './styles.module.css';

const Component = ({ history }) => {
    return (
        <div className={styles.container}>
            {history && history.books ? (<Card>
                <h1 className={styles.item}> Historial de compras: </h1>
                {history.books.map(item => <div className={styles.item}> <h4>{`Libro: ${catalog[item.isbn].title}`}</h4> <h4>{`Total: $${item.spent}`}</h4> </div>)}
            </Card>) : <h1> Vuelva a iniciar sesion </h1>}
        </div>
    );
}
export default Component;