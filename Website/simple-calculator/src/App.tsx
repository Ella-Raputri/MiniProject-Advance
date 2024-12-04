import React from 'react';
import logo from './logo.svg';
import {BrowserRouter, Routes, Route} from 'react-router-dom';
import './App.css';
import Calculator from './Pages/Calculator';
import SupportPage from './Pages/SupportPage';
import NotFound from './Pages/NotFound';

function App() {
  return (
    <div className="App">
      {/* <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header> */}

      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Calculator/>}></Route>
          <Route path="/supportpage" element={<SupportPage/>}></Route>
          <Route path="*" element={<NotFound/>}></Route>
        </Routes>  
      </BrowserRouter>
      
    </div>
  );
}

export default App;
