import React, { useState } from 'react';
import '../css/supportPage.css';
import BackButton from '../Components/BackButton';

const SupportPage = () => {
  const [data, setData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    topic: '',
    description: '',
  });

  const [errors, setErrors] = useState({
    email: '',
    username: '',
  });

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const usernameRegex = /^[a-zA-Z0-9]{3,20}$/;

  const validateField = (name: string, value: string) => {
    let error = '';
    if (name === 'email' && !emailRegex.test(value)) {
      error = 'Invalid email format.';
    } else if (name === 'username' && !usernameRegex.test(value)) {
      error = 'Username must be 3-20 characters and alphanumeric only.';
    }
    setErrors((prev) => ({ ...prev, [name]: error }));
  };

  const [submitted, setSubmitted] = useState(false);
  const [ticketNo, setTicketNo] = useState<number|null>(null);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setData({ ...data, [name]: value });
    validateField(name, value);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const emailError = emailRegex.test(data.email) ? '' : 'Invalid email format.';
    const username = data.firstName + data.lastName;
    const usernameError = usernameRegex.test(username)
      ? ''
      : 'Username must be 3-20 characters and alphanumeric only.';

    if (emailError || usernameError) {
      alert(`Error: ${emailError + usernameError} Please try again.`)
      setErrors({ email: emailError, username: usernameError });
      return;
    }

    console.log('Form submitted:', data);
    alert(`Form submitted successfully.`)
    const randomTicketNumber = Math.floor(Math.random() * 9000) + 1000;
    setTicketNo(randomTicketNumber);
    setSubmitted(true);
  };

  const isValid = data.firstName && data.lastName && data.email && data.topic;

  return (
    <div className="container">
      <div className="form-container">
        <div className="title-container">
          <BackButton></BackButton>
          <h1>Support Ticket Form</h1>  
        </div>
        
        <hr />

        {submitted? (
          <div className="thank-you-container">
            <label className="thank-you-message">
              Thank you for sending us your report, we will track the problem now.
            </label>
            <p className="ticket-number">Ticket number: <span>{ticketNo}</span></p>
          </div>

        ) : (
          <form onSubmit={handleSubmit}>
            <div className="input-container">

            <div className="input-group">
                <div className="name-container">
                    <label>Name <span className="red-color">*</span></label>            
                    <div className="name-inputs">
                        <div className="name-wrapper">
                            <input
                            type="text"
                            id="firstName"
                            name="firstName"
                            placeholder="Ella"
                            value={data.firstName}
                            onChange={handleChange}
                            required
                            />
                            <label htmlFor="firstName" className="small-label">First</label>
                        </div>
                        <div className="name-wrapper">
                            <input
                            type="text"
                            id="lastName"
                            name="lastName"
                            placeholder="Raputri"
                            value={data.lastName}
                            onChange={handleChange}
                            />
                            <label htmlFor="lastName" className="small-label">Last</label>
                        </div>
                    </div>
                    {errors.username && <span className="error-message">{errors.username}</span>}
                </div>

                <div className="input-wrapper">
                    <label htmlFor="email">Email <span className="red-color">*</span></label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="example@example.com"
                        value={data.email}
                        onChange={handleChange}
                        required
                    />
                    {errors.email && <span className="error-message">{errors.email}</span>}
                </div>

                <div className="input-wrapper">
                    <label htmlFor="topic">Topic <span className="red-color">*</span></label>
                    <div className={`topic-container ${data.topic ? 'selected' : ''}`}>
                        <div className="radio-group">
                            <p>What can we help you today?</p>
                            <label>
                                <input
                                    type="radio"
                                    name="topic"
                                    value="General"
                                    onChange={handleChange}
                                    checked={data.topic === 'General'}
                                    required
                                />
                                General
                            </label>
                            <label>
                                <input
                                    type="radio"
                                    name="topic"
                                    value="Bug"
                                    onChange={handleChange}
                                    checked={data.topic === 'Bug'}
                                    required
                                />
                                Bug
                            </label>
                        </div>
                    </div>
                </div>
            </div>

              <div className="description-wrapper">
                <div className="input-wrapper">
                  <label htmlFor="description">
                    Description <span className="optional">(optional)</span>
                  </label>
                  <textarea
                    id="description"
                    name="description"
                    placeholder="Description Report"
                    value={data.description}
                    onChange={handleChange}
                  />
                </div>
              </div>
            </div>

            <button type="submit" className="submit-button" disabled={!isValid}>
              SEND
            </button>
          </form>
        )}
      </div>
    </div>
  );
};

export default SupportPage;