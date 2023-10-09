import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import Search from './Search.js';

test('renders title', () => {
    render(<Router><Search /></Router>);
    const linkElement = screen.getByText(/Search for a Summoner/i);
    expect(linkElement).toBeInTheDocument();
});
