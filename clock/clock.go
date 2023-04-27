package clock

import "time"

type Clocker interface {
	Now() time.Time
}

type RealClocker struct{}

func (r RealClocker) Now() time.Time {
	return time.Now()
}

type FixedClocker struct{}

func (f FixedClocker) Now() time.Time {
	return time.Date(2023, 4, 27, 12, 34, 56, 0, time.UTC)
}
