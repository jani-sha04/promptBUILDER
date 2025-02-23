import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom';
import BadgeChallenge from './Challenges/bc';

describe('BadgeChallenge Component', () => {
  const mockChallenge = {
    name: 'Zero Waste Week',
    description: 'Reduce your waste to zero for a week',
    reward_points: 100,
    duration_days: 7,
    difficulty: 'medium',
    status: 'available'
  };

  const mockJoin = jest.fn();
  const mockComplete = jest.fn();

  beforeEach(() => {
    render(
      <BadgeChallenge
        challenge={mockChallenge}
        onJoin={mockJoin}
        onComplete={mockComplete}
      />
    );
  });

  test('renders challenge details correctly', () => {
    expect(screen.getByText(mockChallenge.name)).toBeInTheDocument();
    expect(screen.getByText(mockChallenge.description)).toBeInTheDocument();
    expect(screen.getByText('medium')).toBeInTheDocument();
    expect(screen.getByText('7 days')).toBeInTheDocument();
    expect(screen.getByText('100 pts')).toBeInTheDocument();
  });

  test('shows join button for available challenges', () => {
    const joinButton = screen.getByText('Join Challenge');
    expect(joinButton).toBeInTheDocument();
    
    fireEvent.click(joinButton);
    expect(mockJoin).toHaveBeenCalledWith(mockChallenge);
  });

  test('shows complete button for in-progress challenges', () => {
    const inProgressChallenge = { ...mockChallenge, status: 'in_progress' };
    render(
      <BadgeChallenge
        challenge={inProgressChallenge}
        onJoin={mockJoin}
        onComplete={mockComplete}
      />
    );

    const completeButton = screen.getByText('Complete Challenge');
    expect(completeButton).toBeInTheDocument();
    
    fireEvent.click(completeButton);
    expect(mockComplete).toHaveBeenCalledWith(inProgressChallenge);
  });

  test('shows completed badge for completed challenges', () => {
    const completedChallenge = { ...mockChallenge, status: 'completed' };
    render(
      <BadgeChallenge
        challenge={completedChallenge}
        onJoin={mockJoin}
        onComplete={mockComplete}
      />
    );

    expect(screen.getByText('Completed')).toBeInTheDocument();
  });

  test('shows progress bar for in-progress challenges', () => {
    const inProgressChallenge = {
      ...mockChallenge,
      status: 'in_progress',
      progress: 60
    };
    
    render(
      <BadgeChallenge
        challenge={inProgressChallenge}
        onJoin={mockJoin}
        onComplete={mockComplete}
      />
    );

    const progressBar = screen.getByRole('progressbar');
    expect(progressBar).toBeInTheDocument();
    expect(progressBar).toHaveAttribute('aria-valuenow', '60');
  });
});
