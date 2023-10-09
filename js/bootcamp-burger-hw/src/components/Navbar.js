import { Link } from 'react-router-dom';
import './Navbar.css';

const Navbar = () => {
    return (
        <div id="navbar">
            <h1>McKing Burger</h1>
            <div><Link to='/'>Home</Link></div>
        </div>
    );
}

export default Navbar;