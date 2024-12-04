import React, { useCallback, useEffect, useState } from 'react'; 
import KeyButton from '../Components/KeyButton';
import '../css/calculator.css';
import { evaluate } from 'mathjs';
import InfoModal from '../Components/InfoModal';
import HistoryModal from '../Components/HistoryModal';

const Calculator: React.FC = () => {
  // const [input, setInput] = useState<string>(''); 
  const [firstNumber, setFirstNumber] = useState<string>('');
  const [secondNumber, setSecondNumber] = useState<string>('');
  const [operator, setOperator] = useState<string>('');
  const [history, setHistory] = useState<string[]>([]);
  const [showHistory, setShowHistory] = useState<boolean>(false);
  const [previousDisplay, setPreviousDisplay] = useState<string>('');

  const [showModal, setShowModal] = useState<boolean>(false);
  const [convertedValues, setConvertedValues] = useState({
    binary: '',
    hex: '',
    octal: ''
  });

  const handleNumberClick = useCallback((value: string) => {
    if (operator === '') {
      setFirstNumber((prev) => prev + value);  
    } 
    else {
      setPreviousDisplay(firstNumber + ' ' + (operator === '*'? 'x' : operator));
      setSecondNumber((prev) => prev + value); 
    }
  }, [operator, firstNumber]);

  const handleOperatorClick = useCallback((value: string) => {
    if (firstNumber !== '') {
      setPreviousDisplay(firstNumber);
      setOperator(value);  
    }
    if (secondNumber === '') {
      setSecondNumber(''); 
    }
  }, [firstNumber, secondNumber]);
  
  const calculate = useCallback(() => {
    if (firstNumber && operator && secondNumber) {
      try {
        const result = evaluate(`${firstNumber} ${operator} ${secondNumber}`).toString();
        setHistory((prev) => [...prev, `${result}`]);
        setFirstNumber(result);
        setOperator('');
        setSecondNumber('');
        setPreviousDisplay('');
      } 
      catch (error) {
        setFirstNumber('Err');
        setOperator('');
        setSecondNumber('');
        setPreviousDisplay('');
      }
    }
  }, [firstNumber, operator, secondNumber]);

  const clear = useCallback(() => {
    setFirstNumber('');
    setOperator('');
    setSecondNumber('');
    setPreviousDisplay('');
  }, []);

  const deleteOne = useCallback(() => {
    if (secondNumber) {
      setSecondNumber(secondNumber.slice(0, -1));
    } 
    else if (operator) {
      setOperator('');
    } 
    else if (firstNumber) {
      setFirstNumber(firstNumber.slice(0, -1));
    }
  }, [firstNumber, operator, secondNumber]);

  const toggleHistory = () => {
    if (showModal) setShowModal(false);
    setShowHistory((prev) => !prev); 
  }

  const handleConvertClick = useCallback(() => {
    if (showHistory) setShowHistory(false);
    var number = (operator === '')? firstNumber : (secondNumber === '')? operator : secondNumber;
    if (number === '') number = '0'

    if (!isNaN(Number(number)) && number !== '' && 
      Number.isInteger(Number(number)) && 
      !['+', '-', '*', '/'].includes(number)) {
      const num = parseInt(number, 10);
      setConvertedValues({
        binary: num.toString(2),
        hex: num.toString(16).toUpperCase(),
        octal: num.toString(8)
      });
    }
    else {
      setConvertedValues({
        binary: 'Invalid',
        hex: 'Invalid',
        octal: 'Invalid'
      });      
    }
    setShowModal(true);

  }, [firstNumber, secondNumber, operator, showHistory]);
  

  const buttonRows = [
    ['C', 'Del', '?', '/'],
    ['1', '2', '3', 'x'],
    ['4', '5', '6', '-'],
    ['7', '8', '9', '+'],
    ['0', '='],
  ];

  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key >= '0' && event.key <= '9') {
        handleNumberClick(event.key); 
      } 
      else if (event.key === '+' || event.key === '-' || event.key === '*' || event.key === '/') {
        handleOperatorClick(event.key); 
      } 
      else if (event.key === 'Backspace' || event.key === 'Delete') {
        deleteOne(); 
      } 
      else if (event.key === 'Enter' || event.key === '=') {
        calculate(); 
      } 
      else if (event.key === 'Escape' || event.key === 'C' || event.key === 'c') {
        clear(); 
      } 
      else if (event.key === 'h' || event.key === 'H') {
        toggleHistory(); 
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [handleNumberClick, handleOperatorClick, calculate, deleteOne, clear]);

  const displayText = secondNumber || (operator === '*' ? 'x' : operator) || firstNumber;

  return (
    <div className="calc-container">
        <h1>Calculator</h1>
        <div className="calculator-container">
            <div className="calculator-display">
                <button className="history-btn" onClick={toggleHistory}>History</button>
                <div className="history-container">
                  <HistoryModal show={showHistory} history={history} onClose={toggleHistory}></HistoryModal>
                </div>
                
                <button className="convert-btn" onClick={handleConvertClick}>
                  <span className="material-symbols-outlined">info</span>
                </button>
                <div className="convert-container">
                  <InfoModal show={showModal} onClose={() => setShowModal(false)} values={convertedValues} />
                </div>
                
                <div className="prev-display">{previousDisplay}</div>
                <div className="display-text">{displayText || '0'}</div>
            </div>

            <div className="btn-container">
            {buttonRows.map((row, rowIndex) => (
                <div key={rowIndex} className="button-row">
                    {row.map((char, index) => (
                    <KeyButton
                        key={index}
                        value={char}
                        onClick={char === 'C' ? () => clear() : 
                            char === 'Del' ? () => deleteOne() :  
                            char === '=' ? () => calculate() : 
                            ['+', '-', '/'].includes(char) ? () => handleOperatorClick(char) : 
                            char === 'x' ? () => handleOperatorClick('*') :
                            () => handleNumberClick(char)}
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
