import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import App from './App';

afterEach(() => {
    jest.clearAllMocks();
});

test('renders click button', () => {
    render(<App />);
    const buttonElement = screen.getByText(/Click me/i);
    expect(buttonElement).toBeInTheDocument();
});