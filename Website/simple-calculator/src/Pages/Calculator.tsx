import React, { useState } from 'react'; 
import KeyButton from '../Components/KeyButton';
import '../css/calculator.css';
import { evaluate } from 'mathjs';

const Calculator: React.FC = () => {
  const [input, setInput] = useState<string>(''); 

  const handleClick = (value: string) => {
    setInput(input + value); 
  };

  
  const calculate = () => {
    try {
      setInput(evaluate(input).toString());
    } catch (error) {
      setInput('Err');
    }
  };

  const clear = () => {
    setInput('');
  };

  const buttonRows = [
    ['C', 'Del', '?', '/'],
    ['1', '2', '3', 'x'],
    ['4', '5', '6', '-'],
    ['7', '8', '9', '+'],
    ['0', '='],
  ];

  return (
    <div className="calc-container">
        <h1>Calculator</h1>
        <div className="calculator-container">
            <div className="calculator-display">
                <div className="display-text">{input || '0'}</div>
            </div>

            <div className="btn-container">
            {buttonRows.map((row, rowIndex) => (
                <div key={rowIndex} className="button-row">
                    {row.map((char, index) => (
                    <KeyButton
                        key={index}
                        value={char}
                        onClick={char === 'C' ? clear : 
                            char === 'Del' ? clear :  
                            char === '=' ? calculate : handleClick}
                    />
                    ))}
                </div>
            ))}
            
            </div>
        </div>
        <br /><br />
    </div>
  );
};

export default Calculator;
