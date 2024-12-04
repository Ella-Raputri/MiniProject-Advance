import React from 'react';

interface HistoryModalProps {
  show: boolean;
  history: string[];
  onClose: () => void;
}

const HistoryModal: React.FC<HistoryModalProps> = ({ show, history, onClose }) => {
  if (!show) return null;

  return (
    <div className="history-modal">
      <div className="history-header">
        <span>History</span>
        <button className="close-btn" onClick={onClose}>×</button>
      </div>
      <div className="history-entry-container">
        {history.map((entry, index) => (
          <div key={index} className="history-entry">
            {entry}
          </div>
        ))}
      </div>
    </div>
  );
};

export default HistoryModal;
