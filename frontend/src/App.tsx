import { useState, useEffect } from 'react';
import './App.css';

const App = () => {
  const [totalClicks, setTotalClicks] = useState(0);

  const handleClick = async () => {
    try {
      const response = await fetch(`http://${process.env.REACT_APP_API_HOSTNAME}:${process.env.REACT_APP_API_PORT}/api/click`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({}),
      });

      if (!response.ok) {
        throw new Error('Error calling API');
      }
      const data = await response.json();
      console.log('Click logged:', data);
    } catch (error) {
      console.error('Error logging click:', error);
    }
  };

  const fetchTotalClicks = async () => {
    try {
      const response = await fetch(`http://${process.env.REACT_APP_API_HOSTNAME}:${process.env.REACT_APP_API_PORT}/api/total_clicks`);
      if (!response.ok) {
        throw new Error('Error calling API');
      }
      const data = await response.json();
      console.log('clicks retrieved: ', data);
      setTotalClicks(data.total_clicks);
    } catch (error) {
      console.error('Error fetching total clicks:', error);
    }
  };

  useEffect(() => {
    fetchTotalClicks();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to {process.env.REACT_APP_YOUR_NAME}'s A to Z deployment! </h1>
        <p>Click the button to log the number of clicks.</p>
        <button onClick={handleClick}>Click me</button>
        <p> This button has been clicked:  {totalClicks} times</p>
      </header>
    </div>
  );
};

export default App;