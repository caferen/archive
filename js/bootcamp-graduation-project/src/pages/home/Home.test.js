import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import Home from './Home.js';

test('renders title', () => {
  render(<Router><Home /></Router>);
  const linkElement = screen.getByText(/Summoner Stalker/i);
  expect(linkElement).toBeInTheDocument();
});
