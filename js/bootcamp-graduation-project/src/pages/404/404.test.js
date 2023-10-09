import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import Error from './404.js';

test('renders about title', () => {
    render(<Router><Error /></Router>);
    const linkElement = screen.getByText(/Page not found!/i);
    expect(linkElement).toBeInTheDocument();
});

