import React, {useState} from 'react';
import Card from '@material-ui/core/Card';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';


import styles from './styles.module.css'

const LogIn = ({onSubmit}) => {
    const [user, setUser] = useState('');
    const [pass, setPass] = useState('');

    const handleUserChange = e => {
        setUser(e.target.value);
    }

    const handlePassChange = e => {
        setPass(e.target.value);
    }

    const handleSubmit = e => {
        e.preventDefault();
        onSubmit(user, pass);
    }

    return (
        <div className={styles.container}>
            <Card>
                <h2 className={styles.title}> Inicie Sesion </h2>
                <form className={styles.formContainer} onSubmit={handleSubmit}>
                    <TextField className={styles.textField} required placeholder="Usuario" onChange={handleUserChange}/>
                    <TextField className={styles.textField} required type="password" placeholder="Contraseña" onChange={handlePassChange}/>
                    <Button type="submit" onClick={handleSubmit}> Ingresar </Button>
                </form>
            </Card>
        </div>
    );
}; 
        
export default LogIn;