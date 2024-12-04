import React from 'react';
import { useNavigate } from 'react-router-dom';

const BackButton = () => {
  const navigate = useNavigate();

  const goBack = () => {
    navigate('/');
  };

  return (
    <button onClick={goBack} className="back-button">
      <span className="material-icons">chevron_left</span>
    </button>
  );
};

export default BackButton;