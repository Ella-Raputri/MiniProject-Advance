const InfoModal = ({ show, onClose, values }: { show: boolean, onClose: () => void, values: any }) => {
    if (!show) return null;

    return (
        <div className="info-modal">
        <div className="modal-header">
            <h3>Conversions </h3>
            <span className="close" onClick={onClose}>&times;</span>
        </div>
        <div className="modal-content">          
            <p><strong>Binary:</strong> {values.binary}</p>
            <p><strong>Hexadecimal:</strong> {values.hex}</p>
            <p><strong>Octal:</strong> {values.octal}</p>
        </div>
        </div>
    );
};

export default InfoModal;