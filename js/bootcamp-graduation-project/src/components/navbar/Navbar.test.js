import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import Navbar from './Navbar.js';

test('renders home button', () => {
    render(<Router><Navbar /></Router>);
    const linkElement = screen.getByText(/Home/i);
    expect(linkElement).toBeInTheDocument();
});

test('renders search button', () => {
    render(<Router><Navbar /></Router>);
    const linkElement = screen.getByText(/Search/i);
    expect(linkElement).toBeInTheDocument();
});

test('renders about button', () => {
    render(<Router><Navbar /></Router>);
    const linkElement = screen.getByText(/About/i);
    expect(linkElement).toBeInTheDocument();
});