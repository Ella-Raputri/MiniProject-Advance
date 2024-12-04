import React from 'react';
import { useNavigate } from 'react-router-dom';

interface ButtonProps {
  value: string;
  onClick?: (value: string) => void;
}

const KeyButton: React.FC<ButtonProps> = ({ value, onClick }) => {
  const navigate = useNavigate();

  const handleClick = () => {
    if (value === '?') {
      navigate('/supportpage');
    } 
    else if (onClick) {
      const valueClick = value === 'x' ? '*' : value;
      onClick(valueClick);
    }
  };

  const classStyle =
    value === '0' || value === '='
      ? 'long-calculator-button'
      : value === '?'
      ? 'brown-calculator-button' 
      : 'calculator-button';

  return (
    <button className={classStyle} onClick={handleClick}>
      {value}
    </button>
  );
};

export default KeyButton;
