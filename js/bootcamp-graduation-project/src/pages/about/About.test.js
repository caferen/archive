import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import About from './About.js';

test('renders about title', () => {
    render(<Router><About /></Router>);
    const linkElement = screen.getByText(/About Summoner Stalker/i);
    expect(linkElement).toBeInTheDocument();
});

test('renders first paragraph', () => {
    render(<Router><About /></Router>);
    const linkElement = screen.getByText(/Summoner Stalker is a tool to help you analyze the favorite champions of League of Legends players./i);
    expect(linkElement).toBeInTheDocument();
});

test('renders last paragraph', () => {
    render(<Router><About /></Router>);
    const linkElement = screen.getByText(/If you're not getting any results, that's because the API key had expired. Contact me in that case./i);
    expect(linkElement).toBeInTheDocument();
});